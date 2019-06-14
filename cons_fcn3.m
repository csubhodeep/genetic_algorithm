function [ c ] = cons_fcn3( a,b )
%CONS_FCN Summary of this function goes here
%   Detailed explanation goes here
s = size(a);
n = s(1,1);
for i = 1:n
    if ((((a(i,1)) - 5)^2 + a(i,2)^2) <= 25) && (((a(i,1) - 8)^2 + (a(i,2) + 3)^2) >= 7.7)
        c(i,1) = b(i,1);
    else
        c(i,1) = 0;
    end

end

end

