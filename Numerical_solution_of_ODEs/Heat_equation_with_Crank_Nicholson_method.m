clear; clc; close all;

% Heat diffusion with Crank-Nicholson Method

L = 1;  % length of the wire
T =1;  % final time

% parameters for the Crank-Nicholson method
K = 2500;  % the number of time steps
dt = T/K; n = 50.;  % the number of space steps
dx = L/n; cond = 1/2;  % conductivity
b = cond*dt/(dx*dx); 

% Initial temperature of the wire : a sinus.
for i = 1:n+1
    x(i) =(i-1)*dx;
    u(i, 1) =sin(pi*x(i));
end

% Temperature at the boundary (T=0)
for k = 1:K+1
    u(1, k) = 0.;
    u(n+1, k) = 0.;
    t(k) = (k-1)*dt;
end

% Defining the matrices M_right and M_left in the method
aal(1:n-2) = -b;
bbl(1:n-1) = 2.+2.*b;
ccl(1:n-2) = -b;
MMl = diag(bbl,0)+diag(aal,-1)+diag(ccl,1);

aar(1:n-2) = b;
bbr(1:n-1) = 2.-2.*b;
ccr(1:n-2) = b;
MMr = diag(bbr,0)+diag(aar,-1)+diag(ccr,1);

% Implementation of the Crank-Nicholson method
for k = 2:K  % time Loop
    uu = u(2 : n, k-1);
    u(2 : n, k) = inv(MMl)*MMr*uu;
end

% the temperature at different selected times
subplot(2,1,1)
plot(x, u(:, 1), '-', x, u(:, 100), '-', x, u(:, 300), '-', x, u(:, 600), '-')
title('Temperature within the Crank-Nicholson method')
xlabel('X'); ylabel('T');

subplot(2,1,2)
mesh(x, t, u')
title('Temperature within the Crank-Nicholson method')
xlabel('X'); ylabel('Temperature');