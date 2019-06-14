function [ z ] = reprod3( a, igen,g, ml )
%REPROD Summary of this function goes here
%   Detailed explanation goes here
s = size(a);
k = s(1,1);
l = s(1,2);

%random pairing
pairing = randperm(k);

for i = 1 : k           %randomising the sequence of the population - single variable
    j = pairing(i);
    c(i,:) = a(j,:);
end
%random crossover flags - single point
r = randi(l-1,k,1);

%crossing over - 2 chromosomes at a time

for m = 1:2:k
    f = r(m);
    v = 0;
    w = 0;
    
    v = c(m,[(f+1):l]);
    w = c(m+1,[(f+1):l]);
    c(m,:) = [c(m,1:f) w];
    c(m+1,:) = [c(m+1,1:f) v];
   
end



%checking the feasability of mutation

if mod(g, igen) == 0
    x = randi(k);
    y = randi(l);
    %c(x,y) = ~c(x,y);
    if c(x,y) == 0
       c(x,y) = 1;
    else c(x,y) = 0;
    end
end

%mlb = bi2de(c);
mlb = bin2dec(c);

for n = 1 : k
    if mlb(n) > ml
        mlb(n) = ml;
    end
    if mlb(n) == 0
        mlb(n) = 1;
    end
end

%c = de2bi(mlb);
c = dec2bin(mlb);

z = c;
end

