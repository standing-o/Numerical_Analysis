clear; clc; close all;

% Heat diffusion with Explicit method

L = 1.;   % length of the wire
T =1;   % final time

% parameters for the explicit method
K = 2500;  % the number of time steps
dt = T/K;
n = 50;  % the number of space steps
dx = L/n;
cond = 1/4;  % conductivity
b = 2*cond*dt/(dx*dx);  % stability parameter (b=<1) (0.5, 1.05)

% initial temperature of the wire : a sinus.
for i = 1:n+1
    x(i) =(i-1)*dx;
    u(i, 1) =sin(pi*x(i));
end

% temperature at the boundary (T=0)
for k=1:K+1
    u(1,k) = 0.;
    u(n+1,k) = 0.;
    t(k) = (k-1)*dt;
end

% implementation of the explicit method
for k = 1:K  % time Loop
    for i = 2:n;  % space Loop
        u(i, k+1) = u(i, k) + 0.5*b*(u(i-1, k)+u(i+1, k)-2.*u(i, k));
    end
end

% the temperature at different selected times
subplot(2,1,1)
plot(x, u(:, 1), '-', x, u(:, 100), '-', x, u(:, 300), '-', x, u(:, 600), '-')
title('Temperature within the explicit method')
xlabel('X'); ylabel('T');

subplot(2,1,2)
mesh(x, t, u')
title('Temperature within the explicit method')
xlabel('X'); ylabel('Temperature');