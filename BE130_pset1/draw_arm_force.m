function draw_arm1()
fig=figure;  ax=gca;
set (fig, 'WindowButtonMotionFcn', @(obj,event)mousemovedetected());   % "mousemovedetected" will be main function.
% It handles reading the current mouse position whenever movement is detected, and then redrawing the screen based on the detected position

L1=1.2;   L2=1.1;   TMAX=1;
redline  = plot([0 0],[1 0],'r','linewidth',7); hold on;  % create the red line for L1 that will be continuously repositioned based on the mouse cursor
blueline = plot([0 0],[1 0],'b','linewidth',5); 
f_points = plot([0],[1],'.','MarkerSize',10);
xlim([-4 4]); ylim([-4 4]);
phi_set = linspace(0,2*pi,100);
% linspace
xlabel('x-position')
ylabel('y-position')

    function mousemovedetected() 
        if overaxis(ax),
            C = get (ax, 'CurrentPoint');   % read the current mouse position (x,y)
            x = C(1,1);
            y = C(1,2);

            theta1 = atan2(y,x) - acos( (L2^2 - L1^2 - x^2 - y^2) / ( -2*L1*sqrt( (x^2+y^2) ) ) );    
            theta2 = pi - acos( (x^2+y^2-L1^2-L2^2) / (-2*L1*L2) ) + atan2(y,x) - acos( (L2^2-L1^2-x^2-y^2) / (-2*L1*sqrt( (x^2+y^2)) ) ) ; 
                
            l1_x = cos(theta1)*L1;
            l1_y = sin(theta1)*L1;

            l2_x = cos(theta2)*L2;
            l2_y = sin(theta2)*L2;
        
            force_points = {}
            for p = 1:length(phi_set)
                val1 = abs(TMAX/ (L1*sin(phi_set(p) - theta1)) );
                val2 = abs(TMAX/ (L2*sin(phi_set(p) - theta2)) );
                
                mag = min([val1, val2]);
%                 fprintf("min %i\n", mag)
%                 mag=1

                deltax = mag*cos(phi_set(p));
                deltay = mag*sin(phi_set(p));
                   
                p_x = l1_x+l2_x+deltax;
                p_y = l1_y+l2_y+deltay;

                force_points{end+1} = [p_x p_y];
            end

            if isreal(theta1) & isreal(theta2),
                set(redline, 'xdata',[0, l1_x]);  % edit these 2 lines to draw L1
                set(redline, 'ydata',[0, l1_y]);
                set(blueline, 'xdata',[l1_x, l1_x+l2_x]); % edit these 2 lines to draw L2
                set(blueline, 'ydata',[l1_y, l1_y+l2_y]);
                
                XY = cell2mat(force_points);
                X = XY(:,1:2:end);
                Y = XY(:,2:2:end);
 
                set(f_points, 'xdata', X);
                set(f_points, 'ydata', Y);
            end
        end % end the if statement
    end % end the mousemovedetected function

    function z = overaxis(ax)   % determines whether the cursor is over the specified axis 'ax'
        C = get (ax, 'CurrentPoint'); Cx=C(1,1); Cy=C(1,2);
        z = (Cx>ax.XLim(1)) & (Cx<ax.XLim(2)) & (Cy>ax.YLim(1)) & (Cy<ax.YLim(2));
    end % end the overaxis function
end
