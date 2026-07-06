function [J,K] = twoByTwoRealJacobiRotationMatrices(A)
    %twoByTwoRealJacobiSVDMatrices 2-by-2 real Jacobi matrices.
    %    [J,K] = twoByTwoRealJacobiSVDMatrices(A) produces orthonormal
    %    Jacobi rotation matrices J and K such that D = J'*A*K is a
    %    diagonal matrix, where A is a 2-by-2 real matrix.
    
    % Reference:
    %    J. R. Cavallaro and F. T. Luk, CORDIC arithmetic for an SVD
    %    processor, in 1987 IEEE 8th Symposium on Computer Arithmetic
    %    (ARITH), 1987, pp. 113–120,
    %    https://doi.org/10.1109/ARITH.1987.6158686.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen

    coder.inline('never')
    a = A(1,1);
    b = A(1,2);
    c = A(2,1);
    d = A(2,2);
    % theta_sum  =  theta1 + theta2
    % theta_diff = -theta1 + theta2
    a = setfimath(a,fixed.fimathLike(a,'Floor','Saturate'));
    b = setfimath(b,fixed.fimathLike(a,'Floor','Saturate'));
    c = setfimath(c,fixed.fimathLike(a,'Floor','Saturate'));
    d = setfimath(d,fixed.fimathLike(a,'Floor','Saturate'));
    theta_sum = fixed.internal.svd.normalizedcordicatan2(c+b,d-a);
    theta_diff = fixed.internal.svd.normalizedcordicatan2(c-b,d+a);

    theta_sum = setfimath(theta_sum,fixed.fimathLike(theta_sum,'Floor','Saturate'));
    theta_diff = setfimath(theta_diff,fixed.fimathLike(theta_sum,'Floor','Saturate'));

    theta_left = bitsra(theta_sum - theta_diff, 1);
    theta_right = bitsra(theta_sum + theta_diff, 1);

    % The allowable range of the input to cordicsincos is [-2pi, 2pi).
    [s_left,c_left] = fixed.internal.svd.normalizedcordicsinecosine(theta_left);
    [s_right,c_right] = fixed.internal.svd.normalizedcordicsinecosine(theta_right);
    J = removefimath([c_left s_left;-s_left c_left]);
    K = removefimath([c_right s_right;-s_right c_right]);
end