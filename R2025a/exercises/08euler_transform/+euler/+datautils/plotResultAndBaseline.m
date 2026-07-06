function plotResultAndBaseline(fig,uOut, uBaseline, uIn, angles, angleName)
    
    % Copyright 2018 The MathWorks, Inc.
    figure(fig)
    clf
    a1 = subplot(3,1,1);
    hold on;
    name = ['Rotation of [' num2str(uIn(:)') '] by ' angleName];
    title(name);
    plot(a1,angles, uBaseline(1,:),'r-');
    plot(a1,angles, uOut(1,:),'b-');
    legend('Baseline','Simulation');
    ylabel('X');
    
    
    a2 = subplot(3,1,2);
    hold on;
    plot(a2,angles, uBaseline(2,:),'r-');
    plot(a2,angles, uOut(2,:),'b-');
    ylabel('Y');
    
    
    a3 = subplot(3,1,3);
    hold on;
    plot(a3,angles, uBaseline(3,:),'r-');
    plot(a3,angles, uOut(3,:),'b-');
    ylabel('Z');
    xlabel([angleName ' (Radians)']);
    
    set(fig,'Name',name,'WindowStyle','Docked')
end