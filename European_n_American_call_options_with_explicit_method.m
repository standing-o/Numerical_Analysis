clear; clc; close all;

% Compares European and American Call options by using the explicit method

r = 0.2;  % Interest rate
sigma = 0.25;  % volatility of the underlying
d = 0.3;  % continuous dividend yield
M = 1600;  % the number of time points
N = 160;  % the number of share price points
s_max = 20;  % maximum share price considered
s_min = 0;  % minimum share price considered
T = 1.;  % maturation (expiry)of contract
E = 10;  % exercise price of the underlying

dt = (T/M);  % time step
ds = (s_max - s_min)/N;  % price step

% Initializing the matrix of the option values : v is the European and vam is the American option
v_eu(1:N, 1:M) = 0;
v_am(1:N, 1:M) = 0;

% Initial conditions prescribed by the Call payoff at expiry: V(S,T) = max(E-S, 0)
v_eu(1:N, 1) = max((s_min + (0:N-1)*ds - E), zeros(size(1:N)))';
v_am(1:N, 1) = max((s_min + (0:N-1)*ds - E), zeros(size(1:N)))';

% Boundary conditions prescribed by Call Options with dividends : V(0, t)=0
v_eu(1, 2:M) = zeros(M-1, 1)';
v_am(1, 2:M) = zeros(M-1, 1)';

% V(S,t) = Se^(-d*(T-t))-Ee^(-r(T-t)) as S -> inf
v_eu(N, 2:M) = ((N-1)*ds + s_min)*exp(-d*(1:M-1)*dt) - E*exp(-r*(1:M-1)*dt);
v_am(N, 2:M) = ((N-1)*ds + s_min)*exp(-d*(1:M-1)*dt) - E*exp(-r*(1:M-1)*dt);

% Determining the matrix coeficients of the explicit method
aa = 0.5*dt*(sigma*sigma*(1:N-2).*(1:N-2) - (r-d)*(1:N-2))';
bb = 1 - dt*(sigma*sigma*(1:N-2).*(1:N-2) + r)';
cc = 0.5*dt*(sigma*sigma*(1:N-2).*(1:N-2) + (r-d)*(1:N-2))';

% Implementing the explicit algorithm
for i = 2:M
    v_eu(2:N-1, i) = bb.*v_eu(2:N-1, i-1) + cc.*v_eu(3:N, i-1) + aa.*v_eu(1:N-2, i-1);
    
    % Checks if early exercise is better for the American Option
    v_am(2:N-1, i) = max(bb.*v_am(2:N-1, i-1) + cc.*v_am(3:N, i-1) + aa.*v_am(1:N-2, i-1), v_am(2:N-1, 1));
end

% Reversal of the time components in the matrix as the solution of the BlackScholes
% equation was performed backwards
v_eu = fliplr(v_eu);
v_am = fliplr(v_am);

% Compares the value today of the European (blue) and American (red) Calls V(S,t)
% The green curve represents the payoff at expiry.
plot(s_min + ds*(0:(N-2)), v_eu(1:(N-1), M)', 'g-', s_min + ds*(0:(N-2)), v_eu(1:(N-1), 1)', 'b-', s_min + ds*(0:(N-2)), v_am(1:(N-1), 1)', 'r-');
xlabel('S'); ylabel('V(S,t)');
title('European (blue) and American (red) Call Options');