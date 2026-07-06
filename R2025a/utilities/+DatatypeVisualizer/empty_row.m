function Row = empty_row()
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    persistent S
    if isempty(S)
        S.Index = nan;
        % function
        S.ScriptPath  = '';
        S.FunctionName = '';
        S.FunctionID = nan;
        % prototype
        S.KnownType = true;
        S.Prototype = nan;
        % datatype
        S.Size = '';
        S.Class = '';
        S.Complex = nan;
        % fi properties
        S.DataType = '';
        S.Scaling = '';
        S.Signed = nan;
        S.WordLength = nan;
        S.FractionLength = nan;
        S.FixedExponent = nan;
        S.Slope = nan;
        S.SlopeAdjustmentFactor = nan;
        S.Bias = nan;
        S.IsFimathLocal = nan;
        S.RoundingMethod = '';
        S.OverflowAction = '';
        S.ProductMode = '';
        S.SumMode = '';
        S.ProductWordLength = nan;
        S.SumWordLength = nan;
        S.ProductFractionLength = nan;
        S.ProductFixedExponent  = nan;
        S.ProductSlopeAdjustmentFactor = nan;
        S.ProductBias = nan;
        S.SumFractionLength = nan;
        S.SumFixedExponent = nan;
        S.SumSlopeAdjustmentFactor = nan;
        S.SumBias = nan;
        % range
        S.MinRange = nan;
        S.MaxRange = nan;
        S.Eps = nan;
        % log info
        S.NodeTypeName = '';
        S.LogReason = char(FixedpointSharedUtils.LogReason.UNKNOWN);
        S.IsLoggedLocation = false;
        S.IsInstrumented = false;
        S.IsArgin = false;
        S.IsArgout = false;
        S.IsGlobal = false;
        S.IsPersistent = false;
        % logs
        S.SimMin = nan;
        S.SimMax = nan;
        S.IsAlwaysWholeNumber = false;
        S.OutOfRange = false;
        S.RatioOfRange = nan;
        % histogram
        S.NumberOfZeros = nan;
        S.NumberOfPositiveValues = nan;
        S.NumberOfNegativeValues = nan;
        S.TotalNumberOfValues = 1;
        S.SimSum = nan;
        S.HistogramOfPositiveValues = nan;
        S.HistogramOfNegativeValues = nan;
        % overflow/underflow
        S.ProposedSignedness = '';
        S.ProposedWordLength = nan;
        S.ProposedFractionLength = nan;
        S.Underflow = false;
        S.Overflow = false;
        % text
        S.TextBegin = nan;
        S.TextEnd = nan;
        S.LineNumber = nan;
        S.Expression = '';
        S.SymbolName = '';
        S.LoggedField = '';
        S.HistogramRange = [-128,127];
    end
    Row = S;
end
