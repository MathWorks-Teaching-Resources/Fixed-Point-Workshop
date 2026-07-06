%% TEST INPUT
[b,x,z,t] = fir_filter_inputs;
p = 1;
y = zeros(size(x));

%% ALGORITHM
for n=1:length(x)
    p = incrementCircularPointer(p,length(b));
    z(p) = x(n);
    acc = 0;
    k = p;
    for j = length(b):-1:1
        k = incrementCircularPointer(k,length(b));
        acc = acc + b(j)*z(k);
    end
    y(n) = acc;
end

%% VERIFY RESULTS
clf
h1 = subplot(2,1,1);
plot(t,x,t,y)
legend('Chirp Input','Filtered Output')
title('Filter Output')
h2 = subplot(2,1,2);
plot(t,y-filter(b,1,x));
title('Difference between algorithm and builtin MATLAB filter');
linkaxes([h1 h2],'x')

