function [ b ] = diversity3( a, nv, inps, w )
%DIVERSITY Summary of this function goes here
%   Detailed explanation goes here
s = size(a);
n = s(1,1);


max_fit = max(a(:,1));

for i = 1:n
    if a(i,1) == max_fit
        for j = 1:nv
        max_loc(1,j) = inps(a(i,1+j),j);
        end
    end
end
    

for i = 1:n
for j = 1:nv
    x(i,j) = (inps(a(i,j+1),j) - max_loc(1,j))^2;
end
end

for i = 1:n
    x(i,nv+1) = sum(x(i,:));
    x(i,nv+2) = sqrt((x(i,nv+1)));
end

max_div = max(x(:,nv+2));
    
for i = 1:n
    if x(i,nv+2) == 0
        x(i,nv+2) = max_div + 1;
    end
    
end

max_div = max(x(:,nv+2));


% calculating the diversity scaling factor
df = max_fit/max_div;

% assigining fitness according to the diversity

a(:,nv+2) = w*df*x(:,nv+2) + (1-w)*a(:,1);

a = sortrows(a,nv+2);

for j = 1:nv
b(:,j) = a(:,j+1);
end

end

