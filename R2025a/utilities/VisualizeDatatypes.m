function varargout = VisualizeDatatypes(mexfile,fig,fun,varargin)
%VisualizeDatatypes Visualize Datatypes
%
%   VisualizeDatatypes(MEXFILE) visualizes datatypes logged in instrumented
%   MATLAB Executable (mex) file, MEXFILE.  The instrumented mex file  must
%   be generated using buildInstrumentedMex with the -histogram option, and
%   the instrumented mex file must have been run before calling
%   VisualizeDatatypes.
%
%   VisualizeDatatypes(MEXFILE, FIG) uses figure(FIG) as the first figure
%   created, and subsequent figures are numbered successively.
%
%   VisualizeDatatypes(MEXFILE, FIG, FUN) only shows information from
%   function named FUN.
%
%   VisualizeDatatypes(MEXFILE, FIG, FUN, ...) passes additional arguments 
%   to showInstrumentationResults.
%
%   V = VisualizeDatatypes(...) returns a DatatypeVisualizer.ExpressionTable
%   object that has fields with MATLAB Table objects containing the logged
%   information for all expressions (e.g. +, -, subscripted assignment), and
%   for all named variables (e.g. a, b, c, x, y, z).
%
%   VisualizeDatatypes(VIS,...) where VIS is a
%   DatatypeVisualizer.ExpressionTable object visualizes datatypes from the
%   object.
%
%   Example:
%
%   %% Create the following MATLAB Function named mysum.m:
%
%      function y = mysum(x)
%          y = cast(0,'like',x);
%          for n=1:length(x)
%              y(:) = y + x(n);
%          end
%      end
%
%   %% Build an instrumented mex from it, run it, and visualize data types:
%
%   x = fi(randn(10,1),1,16,14,'DataType','ScaledDouble');
%   buildInstrumentedMex mysum -args {x} -histogram
%   y = mysum_mex(x);
%   V = VisualizeDatatypes('mysum_mex');
%
%   See also: buildInstrumentedMex, showInstrumentationResults.

%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2016 The MathWorks, Inc.
    if nargin<2
        fig = [];
    end
    if isempty(fig)
        % To allow the first figure to be defaulted if you want to just enter
        % FUN.
        fig = 1;
    end
    if nargin<3
        fun = '';
    end
    %#ok<*NASGU>

    global PLOT_EXPRESSION_NAMES
    plot_expression_names = true;
    PLOT_EXPRESSION_NAMES = plot_expression_names;
    
    if isa(mexfile,'DatatypeVisualizer.ExpressionTable')
        vis = mexfile;
    else
        vis = DatatypeVisualizer.ExpressionTable(mexfile);
        showInstrumentationResults(mexfile,varargin{:});
    end
    lastFig = visualize(vis,fig,fun);
    
    commandwindow
    
    disp('Done visualizing data types');
    
    if nargout>0
        varargout{1} = vis;
    end
    if nargout>1
        varargout{2} = lastFig;
    end
end
