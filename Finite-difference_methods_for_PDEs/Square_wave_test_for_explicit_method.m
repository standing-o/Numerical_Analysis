clear; clc; close all;

% Square-wave test for the explicit method to solve the advection equation

% the maximum of length and time
L_max = 1; T_max = 1;  

% advection velocity
c = 1;

% parameters for explicit method
T = 3000;  % the number of time steps
dt = T_max/T;   
n = 30;   % the number of space steps
n_init = 15;  % wave-front : intermediate point from which u=0
dx = L_max/n; 
b = c*dt/(2*dx);

% initial value of the function u (amplitude of the wave)
for i = 1:n+1
    if i < n_init
        u(i, 1) = 1;
    else
        u(i, 1) = 0;
    end
    x(i) = (i-1)*dx;
end

% value of the amplitude at the boundary
for k = 1:T+1
    u(1, k) = 1;
    u(n+1, k) = 0;
    t(k) = (k-1)*dt;
end

% implementation of the explicit method
for k = 1:T  % time loop
    for i = 2:n  % space loop
        u(i, k+1) = u(i, k) - b*(u(i+1, k) - u(i-1, k));
    end
end

% the wave at different selected times
plot(x, u(:, 1), '-', x, u(:, 10), '-', x, u(:, 50), '-', x, u(:, 100), '-')
title('square-wave test within the explicit method')
xlabel('X'); ylabel('amplitude(X)')

