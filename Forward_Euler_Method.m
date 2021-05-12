clear;

% coefficients of the equation : ax' = bx + ct
a=1; b=-2; c=1;

% initial and final times
tinit = 0; tmax = 5;

% the number of times
maxt = 3000; dt = (tmax-tinit)/maxt;

% initial condition
x(1) = 1; t(1) = tinit;

% time loop
for j = 1:maxt
    x(j+1) = x(j) + dt*((b*x(j) + c*(j)*dt)/a);
    t(j+1) = tinit + j*dt;
end

% figure
plot(t,x);
title('Euler Method');
xlabel('T')
ylabel('X(t)')
