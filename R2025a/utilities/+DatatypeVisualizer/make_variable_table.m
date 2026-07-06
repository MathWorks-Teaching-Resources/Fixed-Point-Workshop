function V = make_variable_table(CompilationReport)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.


    V = build_table(CompilationReport);
    V = struct2table(V,'AsArray',true);

end
function V = build_table(CompilationReport)
    MxInfos = CompilationReport.inference.MxInfos;
    MxArrays = CompilationReport.inference.MxArrays;
    Functions = CompilationReport.inference.Functions;
    instrumentedVariables  = CompilationReport.InstrumentedData.InstrumentedVariables;
    V = DatatypeVisualizer.empty_row();
    Index = 0;
    for i=1:length(instrumentedVariables.Functions)
        
        FunctionName = instrumentedVariables.Functions(i).FunctionName;
        FunctionID = instrumentedVariables.Functions(i).FunctionID;
        if FunctionID<=0 || FunctionID > length(Functions)
            continue;
        end
        ThisFunction = Functions(FunctionID);
        ScriptID = ThisFunction.ScriptID;
        if ScriptID<=0 || ScriptID > length(CompilationReport.inference.Scripts)
            continue;
        end
        ScriptText   = CompilationReport.inference.Scripts(ThisFunction.ScriptID).ScriptText;
        ScriptPath = CompilationReport.inference.Scripts(ThisFunction.ScriptID).ScriptPath;
        newlines = emlcprivate('emcLinePositions',ScriptText);
        unicodemap = emlcprivate('makeunicodemap',ScriptText);
        
        for j=1:length(instrumentedVariables.Functions(i).NamedVariables)
            NamedVariable = instrumentedVariables.Functions(i).NamedVariables(j);
            LoggedFieldNames = NamedVariable.LoggedFieldNames;
            if isempty(LoggedFieldNames)
                % Non-struct
                SimMin = NamedVariable.SimMin;
                SimMax = NamedVariable.SimMax;
                if isempty(SimMax) || isempty(SimMin) || SimMax < SimMin
                    continue; % because nothing was logged
                end
                Index = Index+1;
                HistogramOfPositiveValues = NamedVariable.HistogramOfPositiveValues;
                HistogramOfNegativeValues = NamedVariable.HistogramOfNegativeValues;
                
                TextStarts = NamedVariable.TextStarts;
                TextLength = NamedVariable.TextLength;
                LineNumber = find(TextStarts(1)<newlines,1);% Or by unicode?
                if isempty(LineNumber)
                    LineNumber = 1;
                end
                Expression = NamedVariable.SymbolName;
                % Build table row
                Row = DatatypeVisualizer.empty_row();
                Row.FunctionName = FunctionName;
                Row.FunctionID = FunctionID;
                Row.ScriptPath = ScriptPath;
                Row.TextBegin = TextStarts;
                Row.TextEnd = TextStarts + TextLength - 1;
                Row.LineNumber = LineNumber;
                Row.Expression = Expression;
                
                MxInfoID = NamedVariable.MxInfoID;
                Row = mxInfo_to_table_row(Row,MxInfoID,MxInfos,MxArrays);
                
                % Something was logged
                Row.Index = Index;
                Row.SimMin = SimMin;
                Row.SimMax = SimMax;
                Row.IsAlwaysWholeNumber = logical(NamedVariable.IsAlwaysInteger);
                Row.LoggedField = '';
                Row.HistogramOfPositiveValues = HistogramOfPositiveValues(:);
                Row.HistogramOfNegativeValues = HistogramOfNegativeValues(:);

                Row = DatatypeVisualizer.find_expression_underflow(Row);

                Row.Overflow  = Row.KnownType && ...
                    (Row.SimMin<Row.MinRange || SimMax>Row.MaxRange);

                V(Index) = Row;
            else
                % Struct
                for n = 1:length(LoggedFieldNames)
                    SimMin = NamedVariable.SimMin(n);
                    SimMax = NamedVariable.SimMax(n);
                    HistogramOfPositiveValues = NamedVariable.HistogramOfPositiveValues(:,n);
                    HistogramOfNegativeValues = NamedVariable.HistogramOfNegativeValues(:,n);
                    if isempty(SimMax) || isempty(SimMin) || SimMax < SimMin
                        continue; % because nothing was logged
                    end
                    Index = Index+1;
                    TextStarts = NamedVariable.TextStarts;
                    TextLength = NamedVariable.TextLength;
                    LineNumber = find(TextStarts(1)<newlines,1);% Or by unicode?
                    if isempty(LineNumber)
                        LineNumber = 1;
                    end
                    Expression = NamedVariable.SymbolName;
                    Row = DatatypeVisualizer.empty_row();
                    Row.FunctionName = FunctionName;
                    Row.FunctionID = FunctionID;
                    Row.ScriptPath = ScriptPath;
                    Row.TextBegin = TextStarts;
                    Row.TextEnd = TextStarts + TextLength - 1;
                    Row.LineNumber = LineNumber;
                    Row.Expression = Expression;
                    
                    struct_MxInfoID = NamedVariable.MxInfoID;
                    
                    MxInfoID = get_field_mxinfoid(LoggedFieldNames{n},struct_MxInfoID,MxInfos);
                    
                    Row = mxInfo_to_table_row(Row,MxInfoID,MxInfos,MxArrays);
                    
                    Row.Index = Index;
                    Row.SimMin = SimMin;
                    Row.SimMax = SimMax;
                    Row.IsAlwaysWholeNumber = logical(NamedVariable.IsAlwaysInteger(n));
                    Row.LoggedField = LoggedFieldNames(n);
                    Row.HistogramOfPositiveValues = HistogramOfPositiveValues(:);
                    Row.HistogramOfNegativeValues = HistogramOfNegativeValues(:);

                    Row = DatatypeVisualizer.find_expression_underflow(Row);

                    Row.Overflow  = Row.KnownType && ...
                        (Row.SimMin<Row.MinRange || SimMax>Row.MaxRange);

                    V(Index) = Row;
                end % for n = 1:length(LoggedFieldNames)
            end % if isempty(LoggedFieldNames)
        end % if isempty(LoggedFieldNames)
    end
end % function 


function Row = mxInfo_to_table_row(Row,MxInfoID,MxInfos,MxArrays)
    if MxInfoID<0
        return
    end
    
    prototype = nan;

    mxInfo = MxInfos{MxInfoID};
    
    Row.Size = mxInfo_to_size_str(mxInfo);
    Row.Class = mxInfo.Class;
    
    if isa(mxInfo, 'eml.MxFiInfo')
        % mxInfo.Complex, mxInfo.NumericTypeID
        Row.Complex = mxInfo.Complex;
        T = MxArrays{mxInfo.NumericTypeID};
        if mxInfo.FiMathLocal
            F = MxArrays{mxInfo.FiMathID};
            prototype = fi([],T,F);
        else
            prototype = fi([],T);
        end
        Row.Prototype = prototype;
        % fi properties
        Row.DataType = prototype.DataType;
        Row.Scaling = prototype.Scaling;
        Row.Signed = prototype.Signed;
        Row.WordLength = prototype.WordLength;
        Row.FractionLength = prototype.FractionLength;
        Row.FixedExponent = prototype.FixedExponent;
        Row.Slope = prototype.Slope;
        Row.SlopeAdjustmentFactor = prototype.SlopeAdjustmentFactor;
        Row.Bias = prototype.Bias;
        Row.IsFimathLocal = isfimathlocal(prototype);
        Row.RoundingMethod = prototype.RoundingMethod;
        Row.OverflowAction = prototype.OverflowAction;
        ProductMode = prototype.ProductMode;
        SumMode = prototype.SumMode;
        Row.ProductMode = ProductMode;
        Row.SumMode = SumMode;
        switch ProductMode
            case {'KeepLSB','KeepMSB'}
                Row.ProductWordLength = prototype.ProductWordLength;
            case {'SpecifyPrecision'}
                Row.ProductWordLength = prototype.ProductWordLength;
                Row.ProductFractionLength = prototype.ProductFractionLength;
                Row.ProductFixedExponent  = prototype.ProductFixedExponent;
                Row.ProductSlopeAdjustmentFactor = prototype.ProductSlopeAdjustmentFactor;
                Row.ProductBias = prototype.ProductBias;
        end
        switch SumMode
            case {'KeepLSB','KeepMSB'}
                Row.SumWordLength = prototype.SumWordLength;
            case {'SpecifyPrecision'}
                Row.SumWordLength = prototype.SumWordLength;
                Row.SumFractionLength = prototype.SumFractionLength;
                Row.SumFixedExponent  = prototype.SumFixedExponent;
                Row.SumSlopeAdjustmentFactor = prototype.SumSlopeAdjustmentFactor;
                Row.SumBias = prototype.SumBias;
        end
        % range
        Row.MinRange = double(lowerbound(prototype));
        Row.MaxRange = double(upperbound(prototype));
        switch prototype.DataType
            case 'double'
                Row.Eps = nan;  % Don't show eps for double eps(1);
            case 'single'
                Row.Eps = nan;  % Don't show eps for single double(eps(single(1)));
            case 'boolean'
                Row.Eps = 1;
            otherwise
                Row.Eps = double(lsb(prototype));
        end
    elseif isa(mxInfo, 'eml.MxNumericInfo')
        switch mxInfo.Class
            case 'int8'
                Row.WordLength = 8;
                Row.FractionLength = 0;
                Row.Signed = 1;
            case 'uint8'
                Row.WordLength = 8;
                Row.FractionLength = 0;
                Row.Signed = 0;
            case 'int16'
                Row.WordLength = 16;
                Row.FractionLength = 0;
                Row.Signed = 1;
            case 'uint16'
                Row.WordLength = 16;
                Row.FractionLength = 0;
                Row.Signed = 0;
            case 'int32'
                Row.WordLength = 32;
                Row.FractionLength = 0;
                Row.Signed = 1;
            case 'uint32'
                Row.WordLength = 32;
                Row.FractionLength = 0;
                Row.Signed = 0;
            case 'int64'
                Row.WordLength = 64;
                Row.FractionLength = 0;
                Row.Signed = 1;
            case 'uint64'
                Row.WordLength = 64;
                Row.FractionLength = 0;
                Row.Signed = 0;
            case 'double'
                Row.WordLength = 64;
                Row.FractionLength = 0;
                Row.Signed = 1;
            case 'single'
                Row.WordLength = 64;
                Row.FractionLength = 0;
                Row.Signed = 1;
        end
        
        Row.Complex = mxInfo.Complex;
        prototype = feval(mxInfo.Class,[]);
        Row.Prototype = prototype;
        if isinteger(prototype)
            Row.MinRange = double(intmin(class(prototype)));
            Row.MaxRange = double(intmax(class(prototype)));
            Row.Eps = 1;
        elseif isfloat(prototype)
            Row.MinRange = double(-realmax(class(prototype)));
            Row.MaxRange = double(realmax(class(prototype)));
            Row.Eps = nan;  % Don't show eps for floating-point types
        else
            Row.MinRange = double(-realmax(class(prototype)));
            Row.MaxRange = double(realmax(class(prototype)));
            one = cast(1,'like',prototype);
            Row.Eps = double(eps(one));
        end
    elseif isa(mxInfo,'eml.MxInfo') && strcmpi(mxInfo.Class,'logical')
        Row.WordLength = 1;
        Row.FractionLength = 0;
        Row.Signed = 0;
        Row.Eps = 1;
        Row.MinRange = 0;
        Row.MaxRange = 1;
        Row.Prototype = logical([]);
    end
    % The type is known if the prototype has been set to something
    % other than nan.
    if isnan(prototype)
        Row.KnownType = false;
    end
end % mxInfo_to_table_row

function MxInfoID = get_field_mxinfoid(FieldName,struct_MxInfoID,MxInfos)
    MxInfoID = -1;
    if struct_MxInfoID<1
        return
    end
    
    struct_mxinfo = MxInfos{struct_MxInfoID};
    dots = strfind(FieldName,'.');
    if isempty(dots)
        field = FieldName;
    else
        field = FieldName(1:dots(1)-1);
    end
    if isfield(struct_mxinfo,'StructFields')
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


% From: John Elliott <John.Elliott@mathworks.com>
% Date: Friday, December 13, 2013 12:36 PM
% To: Tom Bryan <tom.bryan@mathworks.com>
% Cc: Fred Smith <Fred.Smith@mathworks.com>
% Subject: RE: How to tell constants from inference CompilationReport?

% Hi Tom,
%
% The property ‘MxValueID’ of ‘InferMxInfoLocation’ objects is an
% index into the ‘MxArrays’ property of the inference report
% object. The ‘MxValueID’ property is non-zero for
% constants. Currently used only for function arguments and global
% variables.
%
% -John

