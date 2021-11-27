clear; clc; close all;

% Integrate the first order ODE system x'(t) = -2x(t) + t
% coefficients of the equation : ax' = bx + ct
a=1; b=-2; c=1;

% initial and final times
t_init = 0; t_max = 5;

% the number of times
T = 3000; dt = (t_max - t_init)/T;

% initial condition
x(1) = 1; t(1) = t_init;

% time loop
for j = 1:T
    x(j+1) = x(j) + dt*((b*x(j) + c*(j)*dt)/a);
    t(j+1) = t_init + j*dt;
end

% figure
plot(t, x);
title('Euler Method');
xlabel('t')
ylabel('X(t)')
