close all;
clc;
clear;

n = 100;
p = 2;
%mu = 0;
%sigma = [5,0;0;5];
%X = random("normal", mu, sigma, [n p]);
#mvnrnd()

mu = [2,3];
sigma = [1,1.5;1.5,3];
X = mvnrnd(mu,sigma,n);
y = random("normal", 0, 1, [n 1]);
beta_hat = pinv(X'*X)*X'*y