function instrumented_expressions_to_tab_delimited(mex_name, results)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    
    out_file = fopen([mex_name,'.txt'],'w');
    
    report = results.CompilationReport;
    MxInfos = report.inference.MxInfos;
    MxArrays = report.inference.MxArrays;
    Functions = report.inference.Functions;
    
    % min>max, don't display
    % inf -> realmax
    % -inf -> -realmax
    
    results_table_fields = ...
        {'Index',            'Index',             '%d', 0
         'ScriptPath',    'ScriptPath',     '%s',''
        'FunctionName',   'FunctionName',   '%s', ''
        'FunctionID',     'FunctionID',     '%d', 0
        'Size',           'Size',           '%s',''
        'Class'           'Class'           '%s' ''
        'Complex',        'Complex',        '%s',''
        'DataType',       'DataType',       '%s',''
        'Signedness',     'Signedness',     '%s',''
        'WordLength',     'WordLength',     '%s',''
        'FractionLength', 'FractionLength', '%s',''
        'lowerboundStr',  'lowerbound',     '%s',''
        'upperboundStr',  'upperbound',     '%s',''
        'epsStr',         'eps',            '%s',''
        'SimMinStr'       'SimMin'          '%s' ''
        'SimMaxStr'       'SimMax'          '%s' ''
        'IsAlwaysIntegerStr' 'IsAlwaysInteger' '%s' ''
        'UnicodeStart'    'TextStart'       '%d' 0
        'UnicodeEnd'      'TextEnd'         '%d' 0
         'LineNumber',    'LineNumber',     '%d',0
        'Expression'      'Expression'      '%s' ''
        'LoggedFieldStr' 'LoggedField'      '%s' ''
         'PrototypeStr', 'Prototype', '%s', ''
        'HistogramOfPositiveValues',   'HistogramOfPositiveValues', '%s',''
        'HistogramOfNegativeValues',   'HistogramOfNegativeValues', '%s', ''
        };
    
    results_table = make_table_struct(results_table_fields);
    
    make_table_header(out_file,results_table);
    
    Index = 0;

    for i=1:length(results.Functions)
        FunctionID   = results.Functions(i).FunctionID;
        ThisFunction = Functions(FunctionID);
        ScriptText   = report.inference.Scripts(ThisFunction.ScriptID).ScriptText;
        ScriptPath = report.inference.Scripts(ThisFunction.ScriptID).ScriptPath;
        newlines = emlcprivate('emcLinePositions',ScriptText);
        
        unicodemap = emlcprivate('makeunicodemap',ScriptText);
        
        for j=1:length(results.Functions(i).loggedLocations)
            LoggedLocation = results.Functions(i).loggedLocations(j);
            LoggedFieldNames = LoggedLocation.Fields;
            results_table.FunctionName.value    = results.Functions(i).FunctionName;
            results_table.FunctionID.value      = FunctionID;
            if isempty(LoggedFieldNames)
                % Non-struct
                for k=1:length(LoggedLocation.Locations)
                    SimMin = LoggedLocation.SimMin;
                    SimMax = LoggedLocation.SimMax;
                    HistogramOfPositiveValues = LoggedLocation.HistogramOfPositiveValues;
                    HistogramOfNegativeValues = LoggedLocation.HistogramOfNegativeValues;
                    
                    TextStart = LoggedLocation.Locations(k).TextStart;
                    TextLength = LoggedLocation.Locations(k).TextLength;
                    [UnicodeStart,UnicodeLength] = emlcprivate('uniposition',unicodemap,TextStart,TextLength);
                    UnicodeEnd = UnicodeStart + UnicodeLength - 1;
                    LineNumber = find(TextStart<newlines,1);% Or by unicode?
                    if isempty(LineNumber)
                        LineNumber = 1;
                    end
                    Expression = regexprep(ScriptText((UnicodeStart:UnicodeEnd)),'\n',' ');
                    Expression = regexprep(Expression,'\t',' ');
                    results_table.UnicodeStart.value    = UnicodeStart;
                    results_table.UnicodeEnd.value      = UnicodeEnd;
                    results_table.LineNumber.value      = LineNumber;
                    results_table.Expression.value      = Expression;
                    
                    MxInfoID = LoggedLocation.Locations(k).MxInfoID;
                    dt = mxInfo_to_dt_str(MxInfoID,MxInfos,MxArrays);
                    
                    if ~isempty(SimMax) && ~isempty(SimMin) && SimMax >= SimMin
                        % Something was logged
                        
                        Index = Index+1;
                        results_table.Index.value = Index;
                        results_table.ScriptPath.value = ScriptPath;
                        results_table.Size.value           = dt.sizeStr;
                        results_table.Class.value          = dt.classStr;
                        results_table.Complex.value        = dt.complexStr;
                        results_table.DataType.value       = dt.DataType;
                        results_table.Signedness.value     = dt.Signedness;
                        results_table.WordLength.value     = dt.WordLength;
                        results_table.FractionLength.value = dt.FractionLength;
                        results_table.lowerboundStr.value  = num_to_str(dt.lowerbound);
                        results_table.upperboundStr.value  = num_to_str(dt.upperbound);
                        results_table.epsStr.value         = num_to_str(dt.eps);
                        results_table.SimMinStr.value      = num_to_str(SimMin);
                        results_table.SimMaxStr.value      = num_to_str(SimMax);
                        results_table.IsAlwaysIntegerStr.value = num_to_str(LoggedLocation.IsAlwaysInteger);
                        results_table.LoggedFieldStr.value = '';
                        results_table.PrototypeStr.value = dt.PrototypeStr;
                        results_table.HistogramOfPositiveValues.value = ['[',sprintf('%d ',HistogramOfPositiveValues),']'];
                        results_table.HistogramOfNegativeValues.value = ['[',sprintf('%d ',HistogramOfNegativeValues),']'];
                        make_table_row(out_file,results_table);
                    end % if SimMax >= SimMin
                end % for k=1:length(LoggedLocation.Locations)
            else
                % Struct
                for n = 1:length(LoggedFieldNames)
                    SimMin = LoggedLocation.SimMin(n);
                    SimMax = LoggedLocation.SimMax(n);
                    HistogramOfPositiveValues = LoggedLocation.HistogramOfPositiveValues(:,n);
                    HistogramOfNegativeValues = LoggedLocation.HistogramOfNegativeValues(:,n);
                    if ~isempty(SimMax) && ~isempty(SimMin) && SimMax >= SimMin
                        % Something was logged
                        for k=1:length(LoggedLocation.Locations)
                            TextStart = LoggedLocation.Locations(k).TextStart;
                            TextLength = LoggedLocation.Locations(k).TextLength;
                            [UnicodeStart,UnicodeLength] = emlcprivate('uniposition',unicodemap,TextStart,TextLength);
                            UnicodeEnd = UnicodeStart + UnicodeLength - 1;
                            Expression = regexprep(ScriptText((UnicodeStart:UnicodeEnd)),'\n',' ');
                            Expression = regexprep(Expression,'\t',' ');
                            results_table.UnicodeStart.value    = UnicodeStart;
                            results_table.UnicodeEnd.value      = UnicodeEnd;
                            results_table.LineNumber.value      = LineNumber;
                            results_table.Expression.value      = Expression;
                            
                            struct_MxInfoID = LoggedLocation.Locations(k).MxInfoID;
                            
                            MxInfoID = get_field_mxinfoid(LoggedFieldNames{n},struct_MxInfoID,MxInfos);
                            
                            dt = mxInfo_to_dt_str(MxInfoID,MxInfos,MxArrays);
                            
                            if ~isempty(SimMax) && ~isempty(SimMin) && SimMax >= SimMin
                                % Something was logged
                                
                                Index = Index+1;
                                results_table.Index.value = Index;
                                results_table.ScriptPath.value = ScriptPath;
                                results_table.Size.value           = dt.sizeStr;
                                results_table.Class.value          = dt.classStr;
                                results_table.Complex.value        = dt.complexStr;
                                results_table.DataType.value       = dt.DataType;
                                results_table.Signedness.value     = dt.Signedness;
                                results_table.WordLength.value     = dt.WordLength;
                                results_table.FractionLength.value = dt.FractionLength;
                                results_table.lowerboundStr.value  = num_to_str(dt.lowerbound);
                                results_table.upperboundStr.value  = num_to_str(dt.upperbound);
                                results_table.epsStr.value         = num_to_str(dt.eps);
                                results_table.SimMinStr.value      = num_to_str(SimMin);
                                results_table.SimMaxStr.value      = num_to_str(SimMax);
                                results_table.IsAlwaysIntegerStr.value = num_to_str(LoggedLocation.IsAlwaysInteger(n));
                                results_table.LoggedFieldStr.value = LoggedFieldNames{n};
                                results_table.PrototypeStr.value = dt.PrototypeStr;
                                results_table.HistogramOfPositiveValues.value = fixed.internal.compactButAccurateVector2Str(HistogramOfPositiveValues);
                                results_table.HistogramOfNegativeValues.value = fixed.internal.compactButAccurateVector2Str(HistogramOfNegativeValues);
                                make_table_row(out_file,results_table);
                            end % if SimMax >= SimMin
                        end % for k=1:length(LoggedLocation.Locations)
                    end % if ~isempty(SimMax) && ~isempty(SimMin) && SimMax >= SimMin
                end % for n = 1:length(LoggedFieldNames)
            end % if isempty(LoggedFieldNames)
        end % if isempty(LoggedFieldNames)
    end
end

function printStruct(kstr,out_file,MxInfo,MxInfos)
    %     MxInfo.StructFields(1)
    %   eml.MxFieldInfo handle
    %      MxInfoID: 2
    %     FieldName: 'scalar'
    
    % K>> MxInfo.StructFields(2)
    
    %   eml.MxFieldInfo handle
    %   Package: eml
    %      MxInfoID: 4
    %     FieldName: 'structstruct'
    
    for i = 1:length(MxInfo.StructFields)
        istr = [kstr,'.',int2str(i)];
        MxInfoID = MxInfo.StructFields(i).MxInfoID;
        fprintf(out_file,'| Field %s MxInfoID %d || %s',...
            istr,...
            MxInfoID,...
            MxInfos{MxInfoID}.Class);
        fprintf(out_file,' || %s ',...
            MxInfo.StructFields(i).FieldName);
        fprintf(out_file,'|| || || || || || ');
        fprintf(out_file,'\n');
        fprintf(out_file,'|-\n');
        if isa(MxInfos{MxInfoID},'eml.MxStructInfo')
            printStruct(istr,out_file,MxInfos{MxInfoID},MxInfos);
        end
    end
end

function table = make_table_struct(fields)
    for i=1:size(fields,1)
        table.(fields{i,1}).header = fields{i,2};
        table.(fields{i,1}).format = fields{i,3};
        table.(fields{i,1}).value  = fields{i,4};
    end
end

function make_table_header(out_file,table)
    fields = fieldnames(table);
    for i=1:length(fields)-1
        fprintf(out_file,'%s\t',table.(fields{i}).header);
    end
    fprintf(out_file,'%s\n',table.(fields{end}).header);
end

function make_table_row(out_file,table)
    fields = fieldnames(table);
    for i=1:length(fields)-1
        fmt = sprintf('%s\t',table.(fields{i}).format);
        fprintf(out_file,fmt,table.(fields{i}).value);
    end
    fmt = sprintf('%s',table.(fields{end}).format);
    fprintf(out_file,fmt,table.(fields{end}).value);
    fprintf(out_file,'\n');
end

function str = num_to_str(x)
    if isempty(x)
        str = 'nan';
    elseif isnan(x)
        str = 'nan';
    elseif isinf(x)
        if x>0
            str = fixed.internal.compactButAccurateVector2Str(realmax);
        else
            str = fixed.internal.compactButAccurateVector2Str(-realmax);
        end
    else
        str = fixed.internal.compactButAccurateVector2Str(x);
    end
end

function str = max_abs_str(x,y)
    str = num_to_str(max(abs([x,y])));
end

function sizeStr = mxInfo_to_size_str(mxInfo)
    % This code duplicates a lot of the logic from
    %   toolbox/coder/coder/private/irProcessDataTypes.m subfunction formatStrings
    % It probably should be refactored so both can use it.
    
    sizeStr = '';
    if ~isempty(mxInfo.SizeDynamic)
        staticDynamic = ~any(mxInfo.SizeDynamic);
    else
        staticDynamic = false;
    end
    for i = 1:length(mxInfo.Size)
        if i > 1
            sizeStr = [sizeStr ' x ']; %#ok<AGROW>
        end
        if mxInfo.Size(i) == -1
            dimSize = '?';
        else
            dimSize = int2str(mxInfo.Size(i));
        end
        if i <= numel(mxInfo.SizeDynamic) && mxInfo.SizeDynamic(i)
            dimSize = [':' dimSize]; %#ok<AGROW>
        end
        sizeStr = [sizeStr dimSize]; %#ok<AGROW>
    end
    if staticDynamic
        sizeStr = [sizeStr ' *'];
    end
    
end

function dt = mxInfo_to_dt_str(MxInfoID,MxInfos,MxArrays)
    % This code duplicates a lot of the logic from
    %   toolbox/coder/coder/private/irProcessDataTypes.m subfunction formatStrings
    % It probably should be refactored so both can use it.
    
    dt.sizeStr = '';
    dt.classStr = '';
    dt.complexStr = '';
    dt.DataType = '';
    dt.dtStr = '';
    dt.Signedness = '';
    dt.WordLength = '';
    dt.FractionLength = '';
    dt.Slope = '';  % @todo not done yet - Brenda Zhuang
    dt.Bias = '';  % @todo not done yet - Brenda Zhuang
    dt.lowerbound = [];
    dt.upperbound = [];
    dt.eps        = [];
    dt.PrototypeStr  = '';

    if MxInfoID<0
        return
    end
    
    mxInfo = MxInfos{MxInfoID};
    
    dt.sizeStr = mxInfo_to_size_str(mxInfo);
    dt.classStr = mxInfo.Class;
    
    if isa(mxInfo, 'eml.MxFiInfo')
        % mxInfo.Complex, mxInfo.NumericTypeID
        dt.complexStr = bool2str(mxInfo.Complex);
        T = MxArrays{mxInfo.NumericTypeID};
%        F = MxArrays{mxInfo.FimathID};
        if mxInfo.FiMathLocal
            F = MxArrays{mxInfo.FiMathID};
            prototype = fi([],T,F);
        else
            prototype = fi([],T);
        end
        dt.lowerbound = double(lowerbound(prototype));
        dt.upperbound = double(upperbound(prototype));
        dt.eps = double(lsb(prototype));
        dt.dtStr = tostring(T);
        if isscaleddouble(T) || ~isscaledtype(T)
            dt.DataType = T.DataType;
        end
        if isscaledtype(T)
            dt.Signedness = T.Signedness;
            dt.WordLength = sprintf('%d',T.WordLength);
            if isscalingslopebias(T)
                e = fix(log2(T.Slope));
                if T.Slope == 2^e
                    dt.Slope = sprintf('2^%d',e);
                else
                    dt.Slope = fixed.internal.compactButAccurateNum2Str(T.Slope);
                end
                dt.Bias = fixed.internal.compactButAccurateNum2Str(T.Bias);
            else
                dt.FractionLength = sprintf('%d',T.FractionLength);
            end
        end
        dt.PrototypeStr = prototypestring(prototype);
    elseif isa(mxInfo, 'eml.MxNumericInfo')
        dt.complexStr = bool2str(mxInfo.Complex);
        prototype = feval(dt.classStr,[]);
        dt.PrototypeStr = prototypestring(prototype);
        if isinteger(prototype)
            dt.lowerbound = double(intmin(dt.classStr));
            dt.upperbound = double(intmax(dt.classStr));
            dt.eps = 1;
        else
            dt.lowerbound = -realmax;
            dt.upperbound = realmax;
            dt.eps = eps;
        end
    end
end

function proto = makePrototypeString(symbol_name,...
        proposedSignedness, ...
        proposedWordLength, ...
        proposedFractionLength, ...
        mxInfo,MxArrays,...
        doShowAttachedFimath,...
        prototypeFimath) %#ok<DEFNU>
    if isempty(proposedSignedness) && ...
            isempty(proposedWordLength) && ...
            isempty(proposedFractionLength)
        proto = makeOriginalPrototypeString(symbol_name,mxInfo,MxArrays,doShowAttachedFimath);
    else
        proto = makeProposedPrototypeString(symbol_name,...
            proposedSignedness, ...
            proposedWordLength, ...
            proposedFractionLength, ...
            mxInfo,MxArrays,...
            prototypeFimath);
    end
    if isempty(proto)
        % Add a comment character to lines where there is no prototype so it
        % can be cut-and-pasted with the rest.
        proto = '%';
    else
        proto = [proto,'; %'];
    end
end

function str = bool2str(val)
    if val == 0
        str = 'No';
    else
        str = 'Yes';
    end
end

function MxInfoID = get_field_mxinfoid(FieldName,struct_MxInfoID,MxInfos)
    if struct_MxInfoID<1
        MxInfoID = -1;
        return
    end
        
    struct_mxinfo = MxInfos{struct_MxInfoID};
    dots = strfind(FieldName,'.');
    if isempty(dots)
        field = FieldName;
    else
        field = FieldName(1:dots(1)-1);
    end
    StructFields = struct_mxinfo.StructFields;
    for i = 1:length(StructFields)
        if strcmp(field,StructFields(i).FieldName)
            MxInfoID = StructFields(i).MxInfoID;
            break;
        end
    end
    if MxInfoID>0 && isa(MxInfos{MxInfoID},'eml.MxStructInfo')
        MxInfoID = get_field_mxinfoid(FieldName(dots(1)+1:end),MxInfoID,MxInfos);
    end
    
end

function str = prototypestring(prototype)
    if isfi(prototype)
        str = tostring(prototype.numerictype);
        str = regexprep(str,'numerictype(','fi([],');
        if isfimathlocal(prototype)
            Fstr = tostring(prototype.fimath);
            Fstr = regexprep(Fstr,'...\n','');
            str = [str,Fstr];
            str = regexprep(str,')fimath(',',');
        end
    elseif isnumeric(prototype)
        str = [class(prototype),'([])'];
    else
        str = class(prototype);
    end
end
    
            
