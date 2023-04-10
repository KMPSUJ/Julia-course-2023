
#=
In this file:
 - Integrals.jl
=#


#=
------------------------------------------------------------
                    Integrals
------------------------------------------------------------
=#
using Integrals

#       log(sin(x))
# ----------------------------------
# Integrate:
# \int_0^{2\pi} \log{(\sin{(x)})} dx
# the answer should be: - 1/2 π log(2)

f(x, p) = log(sin(x))

iprob = IntegralProblem(f, 0.0, pi/2)

sol = solve(iprob)
# check the answer
isapprox(sol.u, - 1/2 * pi * log(2))


#       Gauss integral
# ----------------------------------
# Integrate:
# \int_{-\infty}^{+\infty} e^{ -x^2 / 2} dx
# the answer should be: √(2π)
sol = solve(IntegralProblem((x, p) -> exp(-x^2 / 2), -Inf, Inf))
isapprox(sol.u, sqrt(2 * pi))


#       Field of a circle
# ---------------------------------

circle(u, p) = (u[1]^2 + u[2]^2 < p[1]^2 ) ? 1.0 : 0.0

params = [1.0] # [ r ]
lb = [-1.0, -1.0] # lower bounds
ub = [1.0, 1.0] # upper bounds

iprob = IntegralProblem(circle, lb, ub, params)

sol = solve(iprob, reltol = 1e-3, abstol = 1e-3)

isapprox(sol.u, pi; rtol = 1e-3, atol = 1e-3)

