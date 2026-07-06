%% Hardware-Efficient Resource Shared QR
%
%
% <matlab:helpview(fullfile(docroot,'fixedpoint/examples/perform-qr-factorization-using-cordic.html')); Perform QR Factorization Using CORDIC>

%% Test real 4x4 QR

%% Set up parameters for the model
resetglobalfimath;
%%
% In this example, the number of rows and columns of A must be 4, and the
% number of columns of B must be >= 1.
%% Purpose
% To first step in solving the matrix equation A*X = B
% is to compute R*X = Q'B, where R is upper-triangular, Q is orthogonal
% (Q*Q' = Q'*Q = eye(size(Q))), and Q*R = A.
m = 4; % Number of rows of A and B.
n = 4; % Number of columns of A.
p = 4; % Number of columns of B.
NumberOfCORDICIterations = 52;
A = 2*rand(m,n)-1;
B = 2*rand(m,p)-1;
real_resource_shared_QR_model
sim real_resource_shared_QR_model

R % Must be upper-triangular
C % = Q'*B

X = R\C
X_should_be = A\B
norm(X - X_should_be)


%% To compute Q and R, set B=eye(size(A,1),'like',A)
% If you set B=eye(size(A,1),'like',A), then the output C = Q'B = Q', so
% set Q = C' to get Q.
m = 4;
n = m;
p = m;
NumberOfCORDICIterations = 52;
A = 2*rand(m,n)-1;
B = eye(size(A,1),'like',A);
sim real_resource_shared_QR_model
R
Q = C'
norm(Q*R - A)

%%
% A is m x m
% B is m x n.  Set n>1 for multiple right-hand sides B in the matrix
% equation A*X = B.
clear
m=6;
n=m;
p=m;
% The number of test inputs
n_test_inputs=100;

% Increase wordlength to 36 to allow room for growth in the QR computation
% and for the divide operation in the backsolve
word_length = 18;

% Assume that the original data was 22-bit signed fractional, which means a
% 21 bit fraction length on the original data.
fraction_length = 14;

% The best-precision number of CORDIC iterations is the word length minus
% one.  If the number of CORDIC iterations is set to smaller than
% word_length - 1, then the latency and clock ticks to next ready signal
% will be shorter, but it will be less accurate.  The number of CORDIC
% iterations should not be set to greater than word_length - 1 because the
% additional iterations are just shifting off zeros.
NumberOfCORDICIterations = word_length - 1;
%NumberOfCORDICIterations = 40;
% The random test inputs are concatentated so that at time k, the inputs
% are A(:,:,k) and B(:,:,k).
% Each element of A and B is a uniform random variable between -1 and +1.
A = 2*rand(m,n,n_test_inputs)-1;
%A = 2*randn(m,m)-1;A = repmat(A,1,1,p);
%A = reshape(1:m*n*n_test_inputs,m,n,n_test_inputs);
%A = magic(3);A = repmat(A,1,1,p);
B = eye(m,p);
B = repmat(B,1,1,n_test_inputs);
% Cast A to fixed-point, and cast B like A.
A = fi(A,1,word_length,fraction_length);
%A = single(A); % xxx
B = cast(B,'like',A);


% Run the model
sim real_resource_shared_QR_model
%
% Calculate and plot the errors
n_outputs = min(n_test_inputs,size(R,3));
log2_norm_error = zeros(1,n_outputs);
for k = 1:n_outputs
    Q_transpose_R_minus_A_should_be_small = double(C(:,:,k))'*double(R(:,:,k)) - double(A(:,:,k));
    log2_norm_error(k) = log2(norm(Q_transpose_R_minus_A_should_be_small));
end
condition_numbers = zeros(1,n_outputs);
for k = 1:n_outputs
    condition_numbers(k) = cond(double(A(:,:,k)));
end
figure(1)
clf
h1 = subplot(2,1,1);
plot(log2_norm_error,'o-')
grid on
title('log2 norm error')
h2 = subplot(2,1,2);
plot(condition_numbers,'o-')
grid on
title('Condition number')
linkaxes([h1,h2],'x')



%#ok<*NASGU,*NOPTS>
