using LinearAlgebra, Plots

# Matrix for this problem
L = [0   2.0 1.25 0;
     0.4 0 0      0;
     0   0.4 0    0;
     0   0   0.3  0]

# initial state of the population
init_state = [8000, 10_000, 10_000, 3000]
tmax = 30

# Matrix 30 x 4 (time x state dimension)
s = zeros(tmax, 4)

s[1, :] = init_state

for i in 2:tmax
    s[i, :] = L * s[i-1, :]
end

plot(s)
