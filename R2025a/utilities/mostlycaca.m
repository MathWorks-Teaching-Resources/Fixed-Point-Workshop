function mostlycaca
%MOSTLYCACA Clear all, close all, but don't close editor
        
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2020 The MathWorks, Inc.
    close all % Close all figure windows
    evalin('base','clear all'); % Clear all in the base workspace
    bdclose all % Close all Simulink models
    try
        % Close all MATLAB Coder Reports
        % Not all versions support this
        codergui.ReportViewer.closeAll;
    catch
    end
    % Close filterDesigner
    hFilterDesigner = findall(0,'Type','figure','tag','FilterDesigner');
    close(hFilterDesigner,'force');
    % Close MATLAB web browser
    % Replace the following with something not Java.
    % com.mathworks.mlservices.MatlabDesktopServices.getDesktop.closeGroup('Web Browser')
    % Clear command window
    clc;
end
