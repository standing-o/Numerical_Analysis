clear; clc; close all;

% Heat diffusion with Implicit method

L = 1;  % length of the wire
T =1;   % final time

% parameters for the implicit method
K = 2500;  % the number of time steps
dt = T/K; n = 50;  % the number of space steps
dx = L/n; cond = 1/4.;  % conductivity
b = cond*dt/(dx*dx); 

% Initial temperature of the wire : a sinus.
for i = 1:n+1
    x(i) = (i-1)*dx;
    u(i, 1) = sin(pi*x(i));
end

% temperature at the boundary (T=0)
for k = 1:K+1
    u(1, k) = 0.;
    u(n+1, k) = 0.;
    t(k) = (k-1)*dt;
end

aa(1:n-2) = -b;
bb(1:n-1) = 1+2*b;
cc(1:n-2) = -b;
MM = inv(diag(bb, 0)+diag(aa, -1)+diag(cc, 1));

% Implementation of the implicit method
for k=2:K % Time Loop
    uu = u(2 : n, k-1);
    u(2 : n, k) = MM*uu;
end

% the temperature at different selected times
subplot(2,1,1)
plot(x, u(:, 1), '-', x, u(:, 100), '-', x, u(:, 300), '-', x, u(:, 600), '-')
title('Temperature within the fully implicit method')
xlabel('X'); ylabel('T');

subplot(2,1,2)
mesh(x, t, u')
title('Temperature within the fully implicit method')
xlabel('X'); ylabel('Temperature');
