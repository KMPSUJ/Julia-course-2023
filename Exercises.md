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
