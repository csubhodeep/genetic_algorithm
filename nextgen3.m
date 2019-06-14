function [ z ] = nextgen3(x,y,k, inps, nv, minomax, w)
%NEXTGEN Summary of this function goes here
%   Detailed explanation goes here

s = size(x);
t = s(1,1);

for i = 1:nv

a1(:,i) = x(:,i);

    for j = 1:t
    a2(j,i) = inps(a1(j,i),i);
    end


b1(:,i) = y(:,2+nv+i);

    for j = 1:t
    b2(j,i) = inps(b1(j,i),i);
    end

end


for j = 1:t
fitness_old(j,1) = obj_fcn3(a2(j,:));

for i = 1:nv 
fitness_old(j,1+i) = (a1(j,i));
end

fitness_new(j,1) = obj_fcn3(b2(j,:));

for i = 1:nv
fitness_new(j,1+i) = (b1(j,i));
end

end

if minomax == 0 
            
        minfit = min(fitness_old(:,1));
            if minfit < 0
                fitness_old(:,1) = (-1).*fitness_old(:,1);
                minfit = min(fitness_old(:,1));
                fitness_old(:,1) = fitness_old(:,1) + abs(minfit);
            elseif minfit > 0
                
                fitness_old(:,1) = 1 ./ fitness_old(:,1);
            else 
                
                fitness_old(:,1) = 0.00001 + fitness_old(:,1);
                fitness_old(:,1) = 1 ./ fitness_old(:,1);
            
            end
            
       minfit = min(fitness_new(:,1));
            if minfit < 0
                fitness_new(:,1) = (-1).*fitness_new(:,1);
                minfit = min(fitness_new(:,1));
                fitness_new(:,1) = fitness_new(:,1) + abs(minfit);
            elseif minfit > 0
                
                fitness_new(:,1) = 1 ./ fitness_new(:,1);
            else 
                
                fitness_new(:,1) = 0.00001 + fitness_new(:,1);
                fitness_new(:,1) = 1 ./ fitness_new(:,1);
            end
                 
end

gen_old = diversity3(fitness_old, nv, inps, w);
gen_new = diversity3(fitness_new, nv, inps, w);


%fitness_old = sortrows(fitness_old,1);
%fitness_new = sortrows(fitness_new,1);

for j = 1:nv
for i = 1 : k
    
    %fitness_old(k-i+1,j+1) = fitness_new(t-i+1,j+1);
    gen_old(k-i+1,j) = gen_new(t-i+1,j);
end
end

for i = 1:nv
%z(:,i) = fitness_old(:,i+1);
z(:,i) = gen_old(:,i);
end
end