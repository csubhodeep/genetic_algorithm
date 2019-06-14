function [ y ] = obj_fcn3( x )
%OBJ_FCN Summary of this function goes here
%   Detailed explanation goes here
s = size(x);
k = s(1,1);
for i = 1:k
    % single variable functions    
    
    %y(i,1) = ((-1)*(x(i,1)-80)^2) + 225;
    %y(i,1) = (x(i,1)-10)^2 + 75;
    %y(i,1) = sin(x(i,1)) + 0.5*sin(3*x(i,1)) + 0.3*cos(5*x(i,1));
    
    % 2 variable functions
    
    %y(i,1) = ((-1)*(x(i,1)-80)^2) + ((x(i,2)+40)^2) + 225;
    %y(i,1) = sin(x(i,1)) + 0.7*sin(3*x(i,1)) + 0.5*sin(5*x(i,2)) + 0.7*cos(3*x(i,2)) + 0.3*cos(5*x(i,2)) - 0.1*cos(7*x(i,2));
    %y(i,1) = (x(i,1)^2) + (x(i,2)^2);
    %y(i,1) = sin(x(i,1)) + cos(x(i,1)) + sin(x(i,2)) + cos(x(i,2));
    %y(i,1) = 20 + (x(i,1)^2) + (x(i,2)^2) - 10*(cos(2*pi*x(i,1)) + cos(2*pi*x(i,2)));
    %y(i,1) = (30 + (x(i,1)^2) + (x(i,2)^2) - 10*(cos(2*pi*x(i,1)) + cos(2*pi*x(i,2))))^(-1);
    %y(i,1) = (1-(x(i,1)))^2 + 100*((x(i,2) - (x(i,1)^2))^2);
    %y(i,1) = (-1)*cos(x(i,1))*cos(x(i,2))*exp(-(((x(i,1) - pi)^2) + (x(i,2) - pi)^2));
    
    % multi variable functions
    
    %y(i,1) = ((1-(x(i,1)))^2 + 100*((x(i,2) - (x(i,1)^2))^2)) + ((1-(x(i,2)))^2 + 100*((x(i,3) - (x(i,2)^2))^2)) + ((1-(x(i,3)))^2 + 100*((x(i,4) - (x(i,3)^2))^2));
     y(i,1) = train_ml_abalone_ga(x(i,1),x(i,2),x(i,3),x(i,4),x(i,5),x(i,6),x(i,7));
    
    %y(i,1) = x(i,1)^2 + x(i,2)^2 + x(i,3)^2 + x(i,4)^2;
end

