function [ ] = check3( lower_lim, upper_lim, res, nv)

%CHECK Summary of this function goes here
%   Detailed explanation goes here
if nv == 1
    i = 1;
    for x = lower_lim(1):res(1):upper_lim(1)
    %b(i,1) = x;
    %y(i,1) = (x-10)^2 + 75;
    i = i + 1;
    end
    plot(b,y);
    hold all
else

[a,b] = meshgrid(lower_lim(1):res(1):upper_lim(1),lower_lim(2):res(2):upper_lim(2));
j = 1;
for x = lower_lim(1):res(1):upper_lim(1)
    i = 1;
    for y = lower_lim(2):res(2):upper_lim(2)
    %z(i,j) = sin(x) + 0.7*sin(3*x) + 0.5*sin(5*y) + 0.7*cos(3*y) + 0.3*cos(5*y) - 0.1*cos(7*y);
    %z(i,j) = ((-1)*(x-80)^2) + ((y+40)^2) + 225;
    %z(i,j) = (x^2)*sin(x) + (y^2)*cos(y);
    %z(i,j) = (x^2) + (y^2);
    %z(i,j) = sin(x) + sin(y) + cos(x) + cos(y);
    z(i,j) = 20 + (x^2) + (y^2) - 10*(cos(2*pi*x) + cos(2*pi*y));
    %z(i,j) = (30 + (x^2) + (y^2) - 10*(cos(2*pi*x) + cos(2*pi*y)))^(-1);
    %z(i,j) = (1-x)^2 + 100*((y - (x^2))^2);
    %f1(i,j) = (4*(x)^2 + 4*(y)^2);
    %f2(i,j) = (x - 5)^2 + (y - 5)^2;
    %z(i,j) = f1(i,j) + f2(i,j);
    %z(i,j) = (-1)*cos(x)*cos(y)*exp(-(((x - pi)^2) + (y - pi)^2));
    i = i+1;
    end
    j = j+1;
end
mesh(a,b,z);
hold
end
end

