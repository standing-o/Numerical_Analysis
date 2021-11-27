clear; clc; close all;

% Square-wave test for the Lax method to solve the advection equation

% the maximum of length and time
L_max = 1; T_max = 1;  

% advection velocity
c = 1;

% Parameters for the Lax method
T = 350;  % the number of time steps
dt = T_max/T;
n = 300;  % the number of space steps
n_init=50; % wave-front : intermediate point from which u=0

dx = L_max/n; 
b = c*dt/(2*dx);

% stable for abs(b)=< 1/2 but it gets difussed unless abs(b)=1/2
% Initial value of the function u (amplitude of the wave)
for i = 1:(n+1)
    if i < n_init
        u(i, 1) = 1.;
    else
        u(i, 1) = 0.;
    end
    x(i) =(i-1)*dx;
end

% value of the amplitude at the boundary at any time
for k = 1:T+1
    u(1, k) = 1.;
    u(n+1, k) = 0.;
    t(k) = (k-1)*dt;
end

% Implementation of the Lax method
for k = 1:T % time loop
    for i = 2:n  % space loop
        u(i, k+1) =0.5*(u(i+1, k)+u(i-1, k))-b*(u(i+1, k)-u(i-1, k));
    end
end

% the evolution of the wave
subplot(1,2,1)
mesh(x, t, u')
title('Square-wave test within the Lax Method')
xlabel('X'); ylabel('T');

subplot(1,2,2)
plot(x, u(:, 1), '-', x, u(:, 20), '-', x, u(:, 50), '-', x, u(:, 100), '-')
title('Square-wave test within the Lax Method')
xlabel('X'); ylabel('Amplitude(X)');