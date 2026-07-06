function visualize_cordic(x,y,varargin) %#codegen
    % Modified from toolbox/fixedpoint/fidemos/cordicqr_makeplots.m to
    % show just one cordic iteration.
    if nargin < 1
        x = 10;
    end
    if nargin < 2
        y = 20;
    end

    A = [x;y];
    niter = 10;
    one = 1;

    PLOT_CORDIC_ROTATION = true;
    % Kn is the inverse of the CORDIC gain, a constant computed outside the loop
    Kn = cordic_constants(niter);
    % Number of rows and columns in A
    [m,n] = size(A);
    % Compute R in-place over A.
    R = A;
    % Q is initially the identity matrix of the same type as A.  If
    % manual scaling is chosen, then the identity matrix is scaled by
    % the equivalent of 1.
    if isfi(A) && (isfixed(A) || isscaleddouble(A)) && isequal(one,1)
        % If A is a fi object, then we can pick an optimal type for Q.  Since Q
        % is orthogonal, then all elements will be bounded by 1 in magnitude, and
        % it needs one additional bit for the CORDIC growth factor of 1.6468 in
        % intermediate computations.
        Q = fi(one*eye(m), get(A,'NumericType'), 'FractionLength',get(A,'WordLength')-2);
    else
        Q = coder.nullcopy(repmat(A(:,1),1,m));
        Q(:) = one*eye(m,class(one));
    end
    % Determine axis size based on maximum growth.
    % Make the axis limits to nearest 1/2
    q = quantizer([52 1],'round');
    max_axis = quantize(q,(1/Kn) * sqrt(m) * max(abs(double(A(:)))));
    ax = [-max_axis max_axis -max_axis max_axis];
    % Compute [R Q]
    for j=1:n
        for i=(j+1):m
            % Apply Givens rotations, zeroing out the i-jth entry below
            % the diagonal.  Apply the same rotations to the columns of Q
            % that are applied to the rows of R so that Q'*A = R.
            %row_col = sprintf('CORDIC rotations about R(%d,%d), R(%d, %d)',j,j,i,j);
            %fprintf('\n\n\n%s\n',row_col);

            %figure;
            clf
            axis(ax);
            axis square;
            set(gca,'Box','on');
            %grid on;
            xlabel('X');
            ylabel('Y')
            title('CORDIC Rotations: Press any key to continue','FontSize',font_size)
            figure(gcf);
            drawnow
            [R(j,j:end),R(i,j:end),Q(:,j),Q(:,i)] = cordicgivens(R(j,j:end),R(i,j:end),...
                Q(:,j),Q(:,i),niter,Kn,...
                i,j,PLOT_CORDIC_ROTATION);
        end
    end
end

function [x,y,u,v] = cordicgivens(x,y,u,v,niter,Kn,row,col,PLOT_CORDIC_ROTATION)
    if PLOT_CORDIC_ROTATION
        theta = linspace(0,2*pi,512);
        magnitude = hypot(x(1),y(1));
        c = magnitude*cos(theta); s = magnitude*sin(theta);
        line(c,s,'Color',circle_color)
        line(x(1),y(1),'Color',first_point_color,'Marker','.','MarkerSize',marker_size,'LineStyle','none');
        text(x(1),y(1),'Initial value = (x_0,y_0)',...
            'HorizontalAlignment','right',...
            'FontSize',font_size);
        xline(0,'Color',xyline_color);
        yline(0,'Color',xyline_color);
        set(gca,'FontSize',font_size);
        drawnow
        pause
    end
    if x(1)<0
        % Compensation for 3rd and 4th quadrants
        x0 = x; y0=y;
        x = -x;  u = -u;
        y = -y;  v = -v;
        if PLOT_CORDIC_ROTATION
            line([x0(1) x(1)],[y0(1) y(1)],'Color',point_color)
            line(x(1),y(1),'Color',point_color,'Marker','.','MarkerSize',marker_size,'LineStyle','none');
            text(x(1),y(1),'Reflect into the right half-plane',...
                'HorizontalAlignment','right',...
                'FontSize',font_size);
            drawnow
            pause
        end
    end
    for i=0:niter-1
        x0 = x; y0 = y;
        u0 = u; v0 = v;
        if y(1)<0
            % Counter-clockwise rotation
            % x and y form R,         u and v form Q
            x(:) = x - bitsra(y, i);  u(:) = u - bitsra(v, i);
            y(:) = y + bitsra(x0,i);  v(:) = v + bitsra(u0,i);
            if PLOT_CORDIC_ROTATION
                plot_next_line(i,x0,x,y0,y,u0,u,v0,v,row,col);
            end
        else
            % Clockwise rotation
            % x and y form R,         u and v form Q
            x(:) = x + bitsra(y, i);  u(:) = u + bitsra(v, i);
            y(:) = y - bitsra(x0,i);  v(:) = v - bitsra(u0,i);
            if PLOT_CORDIC_ROTATION
                plot_next_line(i,x0,x,y0,y,u0,u,v0,v,row,col);
            end
        end
    end
    % Set y(1) to exactly zero so R will be upper triangular without roundoff
    % showing up in the lower triangle.
    x0 = x; y0 = y;
    u0 = u; v0 = v;
    y(1) = 0;
    % Normalize the CORDIC gain
    % Annotation units are relative to the figure, not the axis, so everything must be scaled.
    ylimits = get(gca,'YLim');
    line([magnitude magnitude],[ylimits(2)/2 0],'Color',circle_color,'LineWidth',line_width);
    line([x(1) x(1)],[ylimits(2)/2 0],'Color',circle_color,'LineWidth',line_width);
    text(magnitude + (x(1)-magnitude)/2, ylimits(2)/2 + 0.1, ...
        'CORDIC Growth',...
        'HorizontalAlignment','center',...
        'VerticalAlignment','bottom',...
        'FontSize',font_size);

    x(:) = Kn * x;  u(:) = Kn * u;
    y(:) = Kn * y;  v(:) = Kn * v;

    line([x0(1) x(1)],[y0(1) y(1)],'Color',point_color,'LineWidth',line_width);
    line(x(1),y(1),'Color',last_point_color,'Marker','.','MarkerSize',marker_size,'LineStyle','none');
    text(x(1),y(1),'Final value = K_n * (x_n,y_n)',...
        'HorizontalAlignment','right',...
        'FontSize',font_size);
    drawnow
    title('CORDIC Rotations','FontSize',font_size)
end

function [Kn,phi] = cordic_constants(niter)
    %CORDIC_CONSTANTS  CORDIC constants.
    %   [Kn,PHI] = CORDIC_CONSTANTS(NITER) returns the inverse of the CORDIC growth factor Kn
    %   after NITER iterations, and the vector PHI of CORDIC angles in radians.
    %
    %   Kn quickly converges to around 0.60725.
    Kn = 1/prod(sqrt(1+2.^(-2*(0:double(niter)-1))));
    phi = atan(pow2(-(0:double(niter)-1)));
end

function plot_next_line(i,x0,x,y0,y,u0,u,v0,v,row,col) %#ok
    line([x0(1) x(1)],[y0(1) y(1)],'Color',point_color,'LineWidth',line_width)
    line(x(1),y(1),'Color',point_color,'Marker','.','MarkerSize',marker_size,'LineStyle','none','LineWidth',line_width);
    drawnow
    pause
end

function s = font_size
    s = 18;
end

function l = line_width
    l = 2;
end

function m = marker_size
    m = 40;
end

function color = circle_color
    color = parula_color(1);
end

function color = first_point_color
    color = parula_color(2);
end

function color = point_color
    color = parula_color(3);
end

function color = last_point_color
    color = parula_color(4);
end

function color = xyline_color
    color = 0.5*ones(1,3);
end

function color = parula_color(n)
    colors = [0    0.4470    0.7410
        0.8500    0.3250    0.0980
        0.9290    0.6940    0.1250
        0.4940    0.1840    0.5560
        0.4660    0.6740    0.1880
        0.3010    0.7450    0.9330
        0.6350    0.0780    0.1840];
    color = colors(n,:);
end