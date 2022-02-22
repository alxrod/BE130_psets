function force_diagram()
fig=figure;  ax=gca;
% "mousemovedetected" will be main function.
% It handles reading the current mouse position whenever movement is detected, and then redrawing the screen based on the detected position

L1=1.2;   L2=1.1;   TMAX=1;
xlim([-3.5 3.5]); ylim([-3.5 3.5]);
xlabel('x-position')
x_ar = linspace(-2,2,8);
y_ar = linspace(-2,2,8);
ylabel('y-position')
fprintf("X vars: %g\n", x_ar);
fprintf("Y vars: %g\n", y_ar);
      
fprintf("%i\n", length(x_ar));

hold on;
for i = 1:length(x_ar)
    for j = 1:length(y_ar)
        x = x_ar(i);
        y = y_ar(j);

        theta1 = atan2(y,x) - acos( (L2^2 - L1^2 - x^2 - y^2) / ( -2*L1*sqrt( (x^2+y^2) ) ) );    
        theta2 = pi - acos( (x^2+y^2-L1^2-L2^2) / (-2*L1*L2) ) + atan2(y,x) - acos( (L2^2-L1^2-x^2-y^2) / (-2*L1*sqrt( (x^2+y^2)) ) ) ; 
        

        %If sin evals to 1, TMAX/L1*SIN always > TMAX/L2*SIN since L2>l1
        op = TMAX / L2;

        phi = theta2 + (pi/2);


        deltax = op*cos(phi);
        deltay = op*sin(phi);
        fprintf("cords: %i, %i \n", x, y);

        plot(x,y,'o');
        quiver(x, y, deltax, deltay);
 
    end
end
hold off;

       
end
