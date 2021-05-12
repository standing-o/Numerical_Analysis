# Numerical_Analysis
- My personal MATLAB toolbox for numerical analysis

## 1. Numerical solution of first order ODEs
#### Forward Euler Method - Explicit
- It uses the slope at each point to exgtrapolate and find the next point
$$
\mathbf{V}_1 \times \mathbf{V}_2 =  \begin{vmatrix} 
\mathbf{i} & \mathbf{j} & \mathbf{k} \\
\frac{\partial X}{\partial u} &  \frac{\partial Y}{\partial u} & 0 \\
\frac{\partial X}{\partial v} &  \frac{\partial Y}{\partial v} & 0 \\
\end{vmatrix}
$$
