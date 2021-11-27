clear; clc; close all;

% Evaluates an European Call option by using an explicit method

% params of the problem
r = 0.2;  % Interest rate
sigma = 0.25;  % volatility of the underlying
M = 1600;  % the number of time points
N = 160;  % the number of share price points
s_max = 20;  % maximum share price considered
s_min = 0;  % minimum share price considered
T = 1.;  % maturation (expiry)of contract
E = 10;  % exercise price of the underlying

dt = (T/M);  % time step
ds = (s_max - s_min)/N; % price step

% Initializing the option value
v(1:N, 1:M) = 0;

% Initial conditions prescribed by the European Call payoff at expiry:
% V(S,T) = max(S-E,0);
v(1:N,1) = max((s_min + (0:N-1)*ds - E), zeros(size(1:N)))';

% Boundary conditions prescribed by the European Call:
v(1, 2:M) = zeros(M-1,1)';  % V(0,t)=0
v(N, 2:M) = ((N-1)*ds + s_min) - E*exp(-r*(1:M-1)*dt);  % V(S,t) = S-Eexp[-r(T-t)] as S ->inf

% Determining the matrix coeficients of the explicit method
aa = 0.5*dt*(sigma*sigma*(1:N-2).*(1:N-2)-r*(1:N-2))';
bb = 1-dt*(sigma*sigma*(1:N-2).*(1:N-2)+r)';
cc = 0.5*dt*(sigma*sigma*(1:N-2).*(1:N-2)+r*(1:N-2))';

% Implementing the explicit method
for i = 2:M
    v(2:N-1, i) = bb.*v(2:N-1, i-1)+cc.*v(3:N, i-1)+aa.*v(1:N-2, i-1);
end

% Reversal of the time components in the matrix as the solution of the BlackScholes
% equation was performed backwards
v=fliplr(v);

% the value of the option V(S,t) as a function of S
% at three different times:t=0, T/2 and T (expiry).
subplot(2,1,1)
plot(s_min + ds*(0:N-1),v(1:N,1)', 'r-', s_min + ds*(0:N-1), v(1:N, round(M/2))', 'g-', s_min + ds*(0:N-1), v(1:N,M)', 'b-');
xlabel('S'); ylabel('V(S,t)');
title('European Call Option within the Explicit Method');

% the Value of the option V(S,t)
subplot(2,1,2)
mesh(s_min + ds*(0:N-1), dt*(0:M-1), v(1:N, 1:M)')
title('European Call Option value, V(S,t), within the Explicit Method')
xlabel('S'); ylabel('t');