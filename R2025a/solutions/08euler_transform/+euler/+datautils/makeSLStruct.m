function s = makeSLStruct(dataIn, varargin)
   % Copyright 2018 The MathWorks, Inc.
   
   s.signals.values = dataIn(:);
   % Assume scalar data for now
   s.signals.dimensions = [1];
   if nargin > 1
      s.time = varargin{1}; 
   else
       s.time = [];
   end
end