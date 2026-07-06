%% Givens rotation applied to point (x,y) to transform to (hypot(x,y), 0)
x = 10;
y = 20;
theta = atan2(y,x);

% Givens rotation
G = [cos(theta)  sin(theta)
    -sin(theta)  cos(theta)]

G * [x
     y]

%% hypot is a better way of computing sqrt(x^2+y^2)

hypot(x,y)

% G is orthogonal
G'*G


%#ok<*NOPTS>
