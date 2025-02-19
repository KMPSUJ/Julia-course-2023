# Exercises

Exercises have different level, because the course is for everyone.
If something is too easy just skip it.
If something is to hard (skip it for now, or ask for help).

Basics, Math
------------

1. Solve (approximately) with respect to `x` and print the results:
    - `sin^2(x) = 2cos(exp(pi))`
    - `exp(x) = p` for `p = pi / k` , where `k = {1 .. 10}`

2. Complex numbers
    - Find complex conjugate for:
        - `2 + 3i`
        - `r = 8, phase = 1.23pi`
    - Find complex roots for:
        - `-1`
        - `i`
        - `2 + 8i`
    - Find phase and radius (`z = r exp(phi)`):
        - 1 + i
        - 2 - 3i
    - Find real and imaginary part:
        - `17 exp(i 17/6 pi)`
        - `23 + 8 exp(4 + i 1/61 pi)`

3. Define a matrix describing the following set of equations  
   `3x + 2y + z = 8`  
   `6x + 4y + z = 4`  
   `3x + z = 3`  
   Check if a solution exists (and find it if it exists).  
   Do the same for this set of equations   
   `3x + 2y + z = 8`  
   `6x + 4y + z = 4`  
   `3x + 2y = 3`


Data Structures, Function Definitions
-------------------------------------

1. Implement a 2d-point structure.
   Define functions for:
    - adding two points
    - printing a point
    - getting the distance between them

2. Define a function to check if a number is a prime number.
   (It doesn't have to be efficient.)  
   Then count all prime numbers smaller than 100 000.


Leslie model (LinearAlgebra, Plots)
-----------------------------------

Consider a simple [Leslie matrix model](https://en.wikipedia.org/wiki/Leslie_matrix)
with just 3 age groups (child, adult, elderly) and survival(reproduction) probabilities:  
`child -> adult 60%`  
`adult -> elderly 40%`  
`adult -> child 150%`

1. Define the matrix describing this model
2. Find eigenvalues to determine the behavior of the model.
    - `abs(lambda) > 1` means population growth
    - `abs(lambda) < 1` means population shrink

3. Assuming that at the beginning the population structure was:  
   `(child, adult, elderly) = (10 000, 8000, 1000)`  
   predict the population structure after 3 and 4 cycles.
   Plot the evolution in time.

4. Do the same for some different numbers for example  
   `adult -> child 200%` or `adult -> child 130%`.

5. A stable state exists for (child, adult1, adult2, elderly):  
   `child -> adult1 40%`  
   `adult1 -> adult2 40%`  
   `adult2 -> elderly 30%`  
   `adult1 -> child 200%`  
   `adult2 -> child 125%`  
   Analyse how the system evolves to it (look at the population structure in time).  
   For example take those initial parameters: (8000, 10000, 10000, 3000)

An example solution for this exercise can be found [here](leslie_solution.jl)


Simulate Diffusion
------------------

Numerical approximation for overdamped Langevin equation:  
`x(t + dt) = x(t) + sqrt(dt) * noise(t)`  
where `noise(t)` is white noise (Gaussian distribution).  
This is a model to simulate standard diffusion in one dimension.

1. Plot a few trajectories of such particles.
2. Generate more trajectories, then plot mean x and mean x^2 in time.


Geometric figures
-----------------

The idea of this task is to see how polymorphism works in Julia.
It's more for programers than scientists.
Be aware that the proposed implementation will fail in some "edge cases".

Implement geometric figures that:
 - Are subtypes of an abstract type (named `AbstractFigure`)
 - Have those functions implemented:
    - `is_point_in(f::SomeFigure, x::Real, y::Real)::Bool`
    - `edge_approx(f::SomeFigure)::Mtrix{Float64}`

`edge_approx` should return a table of points which approximate the edge
of the figure `[x1 y1; x2 y2; x3 y3; ...; x100 y100]`.
For simple figures return about 100 points (it won't matter).

1. Define an abstract type `AbstractFigure`

2. Define those Types:
    - `Circle`
    - `Rectangle`

3. Implement functions `is_point_in` and `edge_approx` for `Circle` and `Rectangle`.

4. Make an alias of `Vector{T} where T<:AbstractFigure` named `FigureList`
   It won't be a subtype of `AbstractFigure`.

5. Implement `is_point_in` and `edge_approx` for `FigureList`.  
   Don't care about the number of points returned by `edge_approx`.

6. Implement a function:  
   `overlapping(f1::Union{AbstractFigure, FigureList}, f2::Union{AbstractFigure, FigureList})::Bool`  
   which will tell if two figures overlap (approximate it using `edge_approx`).
   Don't use the fact that `edge_approx` returns exactly 100 points.
   Make this function work "correct" for any number of points returned.

7. Impement `overlapping(f1::Circle, f2::Circle)::Bool`
   in a more efficent way.


Important notes:
 - Look which method of `overlapping` Julia picks
 - See that the generic `overlapping` works for both `FigureList` and `AbstractFigure`
