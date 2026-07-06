function matrixlibhdlsetup(model)
% matrixlibhdlsetup(MODEL) Set Simulink model parameters for matrix library.
%
%   matrixlibhdlsetup('model') changes the parameters of the Simulink
%   model specified by the 'model' argument to values that are
%   commonly used for HDL code generation. The specified model
%   should be open in Simulink before you invoke the matrixlibhdlsetup
%   command. The matrixlibhdlsetup command uses the Simulink set_param
%   function to set up models for HDL code generation quickly and
%   consistently. The model parameters settings provided by
%   matrixlibhdlsetup are intended as useful defaults, but they may not
%   be appropriate for all your applications.
%
%   See also HDLSETUP, VISIONHDLSETUP.

%   Copyright 2019 The MathWorks, Inc.
%     

model = convertStringsToChars(model);

if ~ischar(model)
    warning(message('hdlcommon:hdlcommon:hdlsetup'));
    return
end

% Model Parameters
set_param(model, ...
    'SingleTaskRateTransMsg',    'error', ...
    'MultiTaskRateTransMsg',     'error', ...
    'Solver',                    'fixedstepdiscrete', ...
    'SolverMode',                'SingleTasking', ...
    'FixedStep',                 'auto', ...
    'SaveTime',                  'off', ...
    'SaveOutput',                'off', ...
    'AlgebraicLoopMsg',          'error', ...
    'ShowLineDimensions',        'on',...
    'ShowPortDataTypes',         'on',...
    'BlockReduction',            'off',...
    'ConditionallyExecuteInputs','off',...
    'InlineParams',              'on',...
    'ProdHWDeviceType',          'ASIC/FPGA->ASIC/FPGA',...
    'DataTypeOverride',          'ForceOff',...
    'SignalLoggingSaveFormat',   'Dataset');

% Leave samle time colors alone
% 'SampleTimeColors',          'on',...


% Attach HDL Coder specific settings and implementation bindings to this
% model
attachhdlcconfig(model);

hdlset_param(model,'AdaptivePipelining', 'off');
hdlset_param(model,'BalanceDelays', 'off');
hdlset_param(model,'ClockRatePipelining', 'off');
hdlset_param(model,'ShareAtomicSubsystems', 'off');
hdlset_param(model,'ShareFloatingPointIPs', 'off');
hdlset_param(model,'ShareMATLABBlocks', 'off');
hdlset_param(model,'ShareMultipliers', 'off');
hdlset_param(model,'ShareMultiplyAdds', 'off');
hdlset_param(model,'TransformNonZeroInitValDelay', 'off');
