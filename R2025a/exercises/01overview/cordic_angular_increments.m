function a = cordic_angular_increments(N)
    a = atan(2 .^ -(0:N-1)');
end