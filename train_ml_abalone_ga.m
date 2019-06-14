function [y] = train_ml_abalone_ga(a1,a2,a3,a4,a5,a6,a7)
v = load('abalone.mat','train_abalone_data');

x = v.train_abalone_data;
n = size(x,2);
m = size(x,1);

co_eff = [a1; a2; a3; a4; a5; a6; a7];

y = sum((x(:,1)' - (co_eff'*x(:,3:n)')).^2);