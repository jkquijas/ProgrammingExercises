%N-armed bandit example
%using Softmax Action Selection
%with Boltzmann probability distribution
%over the set of actions

clear;
clc;
close all;

n = 5;
banditProbs = rand(1,n);
banditProbs = banditProbs/sum(banditProbs);
%Initial action value estimate
%Set > 0 for optimistic initialization
%i.e. exploration
Q0 = 1;
%Initialize our action value estimates
Q = ones(1,n)*Q0;
K = zeros(1,n);
alpha = .1;

%Temperature parameter
temperature = .99;
%Number of tests
n_iter = 3000;

for i = 1:n_iter
  %Set jackpot results
  jackpots = binornd(1,banditProbs,[1 n]);
  
  %Compute probabilities
  denom = sum(exp(Q./temperature));
  nomin = exp(Q./temperature);
  probs = nomin./denom;
  
  
  %Choose action according to softmax action selection method
  action = find(rand<cumsum(probs),1,'first');
  
  %Determine action reward
  if(jackpots(action) == 1)
    reward = 10;
  else
    reward = -1;
  end
  K(action) = K(action) + 1;
  alpha = 1/K(action);
  Q(action) = Q(action) + alpha*(reward - Q(action));

%  if(K(action)-1 > 0)
%    %Recompute action values
%    Q(action) = (Q(action)*(K(action)-1))+reward;
%    Q(action) = Q(action)/K(action);
%  else
%    Q(action) = reward;
%  end
  

  
  
end


w1 = 0.5;
bar([1:n],banditProbs,w1,'FaceColor',[0.2 0.2 0.5])
ylim([0 1]);
w2 = .25;
hold on
bar([1:n],probs,w2,'FaceColor',[0 0.7 0.7])
hold off

grid on
titleStr = '%d-Bandit, Softmax Action Selection, Temperature = %.2e';
title(sprintf(titleStr, n, temperature));
ylabel('Jackpot Probability')
legend({'Jackpot Probability','Learned Action Selection Probability'},'Location','northwest')

