% HDL Optimized Euler Transform
%
% Description:
%   This folder contains an HDL Optimized implementation of the Euler
%   transformation. It performs the entire transformation by applying
%   Givens rotations via CORDIC and does not consume any DSP Slices when
%   implemented on an FPGA.
%
%   Run the script test_euler_transform_pipelined.m to run the example
%   model euler_transform_pipelined with basic fixed-point inputs. This
%   script additionally computes the result of the full Euler rotation via
%   matrix multiplication using doubles, and plots a comparison of the
%   fixed-point and double precision results.
%
% Contents:
%   readme.m % This file
%   euler_transform.m % M File demonstrating the algorithm used
%   euler_transform_pipelined.slx: % Fully pipelined implementation of the
%                                  % Euler transformation
%   test_euler_tranform_pipelined.m % M File script to setup
%                                   % euler_transform_pipelined.slx
%   +euler % package directory of utilities used by
%          % test_euler_transform_pipelined.m