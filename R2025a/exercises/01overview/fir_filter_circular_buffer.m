function [y,z,p] = fir_filter_circular_buffer(b,x,z,p,T)
%FIR_FILTER_CIRCULAR_BUFFER Finite impulse response filter with circular buffer.
%
%    [y,z,p] = fir_filter_circular_buffer(b,x,z,p,T)
%    filters the data in vector x using an efficient circular buffer
%    implementation with the filter described by vector b to create the
%    filtered data y.
%
%    The coefficients, b, are the same as used in the MATLAB function filter(b,1,...).
%
%    Output y(n) is equal to
% 
%      y(n) = b(1)*x(n) + b(2)*x(n-1) + ... + b(nb)*x(n-nb+1)
%
%    The states are stored in a circular buffer, z, which should be
%    the same size as b.  For all zero initial states, initialize z as
%    
%      z = zeros(size(b));
%
%    The circular buffer position index p should be initialized to 
%
%      p = 0;
%
%    Example:
%
%      T = fir_filter_double_types([]);
%      b = cast(fir1(16,0.25),'like',T.coeff);
%      t = linspace(0,10*pi,256);
%      x = cast(sin(pi*0.0625*t.^2),'like',T.x);
%      z = cast(zeros(size(b)),'like',T.z);
%      p = cast(0,'like',T.p);
%      y0 = filter(b,1,x);
%      y1 = fir_filter_circular_buffer(b,x,z,p,T);
%      clf
%      subplot(2,1,1)
%      plot(t,x,t,y0,t,y1)
%      legend('Input','Builtin filter','Reverse coefficients filter')
%      subplot(2,1,2)
%      plot(t,double(y0)-double(y1))
%      legend('Difference')

% Copyright 2018 The MathWorks, Inc.

    y = zeros(size(x),'like',T.y);
    nx = length(x);
    nb = length(b);
    for n=1:nx
        p(:) = increment_and_wrap_index(p,nb);
        z(p) = x(n);
        acc = cast(0,'like',T.acc);
        k = p;
        for j = nb:-1:1
            k(:) = increment_and_wrap_index(k,nb);
            acc(:) = acc + b(j)*z(k);
        end
        y(n) = acc;
    end
end
