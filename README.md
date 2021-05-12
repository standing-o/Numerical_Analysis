# Numerical_Analysis
- My personal MATLAB toolbox for numerical analysis

## 1. Numerical solution of first order ODEs
#### Forward Euler Method - Explicit
y<sub>i+1</sub> = y<sub>i</sub> + f(t<sub>i</sub>, y<sub>i</sub>)&Delta;t + O(&Delta;t<sup>2</sup>)
- It uses the slope at each point to exgtrapolate and find the next point  
- O(&Delta;t<sup>2</sup>)

#### Backward Euler Method
- O(&Delta;t<sup>2</sup>)

#### Midpoint Method
- Symmetric method using Taylor expansion that involves only odd powers of &Delta;t
- O(&Delta;t<sup>3</sup>) -> More accurate  
-> but require special initialisation
