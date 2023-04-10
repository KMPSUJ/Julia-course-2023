
#=
In this file:
 - very brief introduction to SciML ecosystem
 - DifferentialEquations
 - Symbolics.jl
 - ModelingToolkit.jl
=#


#=
------------------------------------------------------------
                    SciML workflow
------------------------------------------------------------
https://sciml.ai/
Scientific Machine Learning (SciML) = Scientific Computing + Machine Learning

To make it short SciML gathers many tools in one ecosystem.
The idea is that you learn one package and use all of them.
All those packages are written in pure Julia (as far as I know).
This makes them fast (the main goal of Julia)
and easy to use (the second goal of Julia)

The workflow for SciML is as follows:
1. Define your problem in some way (using "normal" Julia)
 - Write the function you want to minimise
 - Define the function describing the evolution of your dynamical system
 - Write the function you want to integrate
 - Use Symbolics.jl to do the same in abstract form
 - I never done machine learning so I can't help with this
 - some more options available probably

2. Construct a "Problem" object from the previous representation.
Now you specify WHAT is your problem (integrate, minimise, differential equations etc.)
You don't specify HOW to solve it (yet).
ModelingToolkit will be able to convert your problem
to a better form (in terms of solving numerically).

3. Invoke `solve` function to gat a solution.
In this step you can specify the accuracy you need, the algorithms to use etc.
One "Problem" object can be "solved" many times (with different parameters).

4. The solutions form step 3 can now be analysed.
You can repeat step 3 with different parameters to see the difference,
compare which way is better.
=#

#=
------------------------------------------------------------
                    DifferentialEquations
------------------------------------------------------------
=#
using Plots, DifferentialEquations


#       Free fall with drag
# -----------------------------------
# problem as a differentioal eqaution:
# m \ddot x = m g - \beta \dot x
# solution (C - const from inital parameters):
# \dot x(t) = \frac{m g}{\beta} + C \exp{(-\frac{\beta t}{m})}
v_in_free_fall(t, v0, m, g, beta) = m * g / beta - (m * g / beta - v0) * exp( - t * beta / m)

# define the function describing this problem
function free_fall(v, p, t)
    # p[1] -> m
    # p[2] -> g
    # p[3] -> β
    dv = p[2] - p[3] / p[1] * v # dv/dt
    return dv
end

# args as follows:
# Function InitialState TimeSpan Parameters
v0 = 10.0
tspan = (0.0, 10.0)
params = [1., -10.0, 2.] # [ m, g, β ]
prob = ODEProblem(free_fall, v0, tspan, params)

sol = solve(prob)

plot(sol)
plot!(t -> v_in_free_fall(t, 10.0, 1., -10.0, 2.0), 0.0, 10.0, label="theory", alpha=0.6, lw=2.5, ls=:dash)
ylabel!("v(t)")





#       harmonic oscilator
# ----------------------------------
# Problem definition:
# \ddot x = - \omega^2 x
# Solution (A, B from inital condisions):
# x(t) = A \sin{(\omega t)} + B \cos{(\omega t)}

# Eq for the second derivative:  ddx = harmonic_osc(dx,x, p, t)
harmonic_osc(dx, x, p, t) = - p[1]^2 * x

# theoretucal solution for comparison
th_harmonic_osc(t, w, x0, v0) = v0 / w * sin(w*t) + x0 * cos(w*t)

# problem definitoin
w = 1.0
x0 = 1.0
v0 = 2.0 # dx(0)
tspan = (0.0, 10.0)
params = [w] # [ ω ]
prob = SecondOrderODEProblem(harmonic_osc, v0, x0, tspan, params)

# solve
sol = solve(prob)
# plot results
plot(sol)
plot!(t -> th_harmonic_osc(t, w, x0, v0), tspan..., label="theory", alpha=0.6, lw=2.5, ls=:dash)





# for interested:

#       SIRS model (inplace)
# ----------------------------------
# You can also operate on vectors
# the framework works the same.
# This example uses an inplace function,
# which modifies the first argument.

function sirs_model!(us, s, p, t)
    si = p[1] * s[2] * s[1]
    ir = p[2] * s[2]
    rs = p[3] * s[3]
    us[1] = rs - si # dS/dt
    us[2] = si - ir # dI/dt
    us[3] = ir - rs # dR/dt
end

# init conditions and parameters
initState = [0.99, 0.01, 0.0]
pvec = (2.0, 0.3, 0.01)
trng = (0.0, 100.0)

# problem definition
sirsp = ODEProblem(sirs_model!, initState, trng, pvec)
# solve it
sol = solve(sirsp)

plot(sol)

