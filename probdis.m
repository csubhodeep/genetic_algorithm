function [ p ] = probdis( k,b )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
for i = 1:(k-1)
    c = 0;
    for j = 1 : i
        c = c + b(j);
    end
    p(i) = c;
end

end

