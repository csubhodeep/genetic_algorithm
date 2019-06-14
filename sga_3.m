
clc

%asking for user inputs required for initiation
minomax = input('minima-0 or maxima-1:');
nv = input('no of variables:');

for i = 1:nv
lower_lim(i) = input('lower limit:');
upper_lim(i) = input('upper limit:');
res(i) = input('resolution of data - 1; 0.1; 0.01; 0.001 etc:');
end
n = input('population size:');
pom = input('probability of mutation:');
cons = input('unconstrained or constrained - 0/1:');
w = input('weight of diversity in percentage from 0 to 100:');
k = input('percentage of elitism b/w 1 to 99:');
k = ceil((k/100)*n + 1);

w = w/100;

if mod(n,2) == 0 && (k >= 1 && k< n) && (w>=0 && w<1) 

%creating the pool of inputs
%fprintf('creating the pool of inputs');
for i = 1:nv
    c = 1;
    for y = lower_lim(i):res(i):upper_lim(i)
        inps(c,i) = y;
        c = c + 1;
    end
    inp_domain_ind(i,1) = c-1;
end

%executing an auxiliary function to obtain a complete visual feedback
%fprintf('executing an auxiliary function to obtain a complete visual feedback');
if nv <= 2
check3(lower_lim, upper_lim, res, nv);
pause(2);
end

%calculating the length of the binary string required for each variable
%fprintf('calculating the length of the binary string required for each variable');
for i = 1:nv
%nb = de2bi(inp_domain_ind(i,1));
nb = dec2bin(inp_domain_ind(i,1));
nbs(i,:) = size(nb);
nbl(i,1) = nbs(i,2);
end

%starting the ga
%fprintf('starting the ga');

for i = 1:nv
    a(:,i) = randi(inp_domain_ind(i), n, 1);
end

for i = 1:nv
for j = 1:n
      inpop1(j,i) = inps(a(j,i),i);
end
end
m=1;
l=1;
ctr = 0;

for i = 1:nv
igen(i,1) = 0;
counter(i,1) = 0;
end

while ctr < 20 && l <= 80*nv
        
        % generating the population
        
        
        if l == 1
            inpop = inpop1;
        else
            for i = 1:nv
                inpop(:,i) = pop(:,2+nv+nv+nv+i);
            end
        end

        % evaluating the fitness of the population
        
        pop(:,1) = obj_fcn3(inpop);
        
        % shifting & flipping for mathematical robustness
        
        
        if minomax == 1
                    
            minfit = min(pop(:,1));
            buffer = pop(:,1);
            
            if minfit < 0
                
                pop(:,1) = pop(:,1) + abs(minfit);
            end 
            
        else
           minfit = min(pop(:,1));
            if minfit < 0
                buffer = pop(:,1);
                pop(:,1) = (-1).*pop(:,1);
                minfit = min(pop(:,1));
                pop(:,1) = pop(:,1) + abs(minfit);
            elseif minfit > 0
                buffer = pop(:,1);
                pop(:,1) = 1 ./ pop(:,1);
            else 
                buffer = pop(:,1);
                pop(:,1) = 0.00001 + pop(:,1);
                pop(:,1) = 1./ pop(:,1);
            end
            
        end
        
        
        % checking for constraints
        if cons == 1
            pop(:,1) = cons_fcn3(inpop,pop);
        end
        
        
        
        f = sum(pop(:,1));
            

        % assigning the probabilities
        for j = 1 : n
            pop(j,2) = 100*(pop(j,1)/f);
        end
        
        % restoring data
        
           pop(:,1) = buffer;
        

        % forming the mating pool for reproduction
        [r, s] = roulette_wheel3(pop, inps, inpop, inp_domain_ind, nv);
        
        
        % storing the indices of fit chromosomes for all variables
        for i = 1:nv 
            pop(:,2+i) = r(:,i);
        end
        
        % storing successive generations of population
        if l == 1
            for i = 1:nv
            gens(:,i) = s(:,i);
            end
            total_fitness(l,1) = sum(pop(:,1));
            max_fitness(l,1) = max(pop(:,1));
            min_fitness(l,1) = min(pop(:,1));
            avg_fitness(l,1) = total_fitness(l,1)/n;
        else
            for i = 1:nv
            gens(:,(l-1)*nv+i) = pop(:,2+nv+nv+nv+i);
            end
            total_fitness(l,1) = sum(pop(:,1));
            max_fitness(l,1) = max(pop(:,1));
            min_fitness(l,1) = min(pop(:,1));
            avg_fitness(l,1) = total_fitness(l,1)/n;
            if minomax == 1
            if avg_fitness(l,1) >= 0.999999*max_fitness(l,1)
                ctr = ctr + 1;
            end
            else
            if avg_fitness(l,1) <= 1.000001*min_fitness(l,1)
                ctr = ctr + 1;
            end
            end
        end
        
        
        
        for i = 1:nv                            % iterating for all variables    
             
        % encoding all the indices of the population 
            %b = de2bi(pop(:,2+i),nbl(i,1));
            b = dec2bin(pop(:,2+i),nbl(i,1));
        

        % reproduction by crossover and mutation
            
            pm(i,1) = round(l*n*nbl(i,1)*pom);  % calculating the probabilty of mutation
            if pm(i,1) >= 1  && counter(i,1) < 1
                igen(i,1) = l;                  % storing the critical generation of mutation
                counter(i,1) = counter(i,1) + 1;
            end
            p = reprod3(b, igen(i,1), l, inp_domain_ind(i,1));
            %pop(:,2+nv+i) = bi2de(p);
            pop(:,2+nv+i) = bin2dec(p);
        
        end
        
        
                
        % creating the next generation of population by selecting the fittest from the old and new pool of chromosomes
        
        z = nextgen3(r, pop, k, inps, nv, minomax, w);
        for i = 1:nv
            pop(:,2+nv+nv+i) = z(:,i);
        end
        
        % fetching the variables from the input pool 
        for j = 1:nv
        for i = 1:n
            pop(i,2+nv+nv+nv+j) = inps(pop(i,2+nv+nv+j),j);
        end
        end
        
        
        % storing the fitness values for the entire generation
        for i = 1:nv
            cp(:,i) = gens(:,(l-1)*nv+i);
        end
            gen_fitness(:,l) = obj_fcn3(cp);
     
        % plotting the population
        if nv == 2
          scatter3(gens(:,m),gens(:,m+1), gen_fitness(:,l),15,'filled');
          pause(0.5);
          m=m+2;
        elseif nv == 1
          scatter(gens(:,l), gen_fitness(:,l),15,'filled');
          pause(0.1);
        else
          scatter(l, avg_fitness(l,1),15,'filled');
          hold all
          if minomax == 1
              scatter(l, max_fitness(l,1),15,'filled');
          else
              scatter(l, min_fitness(l,1),15,'filled');
          end
        end
         l = l+1;
         pause(1);
end

for i = 1:nv
var(i,1) = gens(1,(l-2)*nv+i);
end
var
best_value = avg_fitness(l-1,1)
total_generations = l-1


else
    
    fprintf('please input even no of population size or check other inputs');
    
    
end
