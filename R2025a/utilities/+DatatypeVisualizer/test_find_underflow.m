% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015 The MathWorks, Inc.



Row.Index
hn = Row.HistogramOfNegativeValues
hp = Row.HistogramOfPositiveValues
%hn = hn{1}
%hp = hp{1}
h = hn + hp
t = 0:length(h)-1;t=t-128;plot(t,h,'.-');figure(gcf)