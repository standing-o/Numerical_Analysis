clear; clc; close all;

% Solving the ax' = bx + ct by midpoint method

% Coefficients of equation ax' = bx + ct
a = 1; b = -2; c = 1;

% initial and final times
t_init = 0; t_max = 5;

% the number of time steps
T = 3000; dt = (t_max - t_init)/T;

% initial conditions
x(2) = 1; x(1) = 1 - dt*((b*x(2) + c*(2)*dt)/a);
t(2) = t_init;

% time loop
for j = 2 : T+1
    x(j+1) = x(j-1) + 2*dt*((b*x(j) + c*(j)*dt)/a);
    t(j+1) = t_init + (j-1)*dt;
end    

plot(t, x);
title("Midpoint method");
xlabel('t'); ylabel('X(t)')