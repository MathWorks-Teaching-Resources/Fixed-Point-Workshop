function [x,y,z] = cordic_vectoring(x,y,z,a,N)
    for i = 1:length(x)
        [x(i),y(i),z(i)] = cordic_vectoring_kernel(x(i),y(i),z(i),a,N);
    end
end