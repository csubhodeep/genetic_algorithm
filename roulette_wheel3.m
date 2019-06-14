function [ y, x ] = roulette_wheel3( a, inps, inpop, inp_domain_ind, nv )
%ROULETTE WHEEL Summary of this function goes here
%   Detailed explanation goes here
s = size(a);
k = s(1,1);
b = a(:,2);

p = probdis(k, b);

r(:,1) = random('unif', 0, 100, k, 1);
for i = 1:k 
    if r(i,1) <= p(1)
        x(i,:) = inpop(1,:);
    end
for l = 1:(k-2)
    if r(i,1) > p(l) && r(i,1) <= p(l+1)
        x(i,:) = inpop(l+1,:);
    end
end
   if r(i,1) > p(k-1)
       x(i,:) = inpop(k,:);
   end
end


%searching the pool of inputs for index value

for l = 1:nv
for i = 1:k
for j = 1:inp_domain_ind(l)
    if inps(j,l) == x(i,l)
        y(i,l) = j;
    end
end
end
end

end

