
#=
In this file:
 - `module` and how export works 
 - `import` `using` to use external libraries 
 - brief introduction to the Julia Package Manger
 - add remove status (basics)
=#


#=
------------------------------------------------------------
                Modules (and scopes a bit)
------------------------------------------------------------
this is how code is grouped in larger projects
similar to namespace in C++
=#

A = 3
module MyMod
    # new global scope inside a module
    try
        println(A)
    catch e
        println("---------------------------------")
        println("Error when prinln(A) was invoked:")
        println(e)
        println("---------------------------------")
    end

    export mymod_public_abc # what will be available for the user who imports this module with "using" statement
    mymod_abc = "abc"
    mymod_public_abc = "public abc"
    mymod_hello(t) = println("Hello $t")

    # modules inside another module
    module InerMod
        export iner_hello
        iner_abc = "iner abc"
        iner_hello(t) = println("hello $t (form inermod)")
    end

    module InerMod2
        export iner_hello
        iner_abc = "iner2 abc"
        iner_hello(t) = println("hello $t (form inermod2)")
    end
end # module

# to access code from a module use the following syntax
MyMod.mymod_hello(123)
MyMod.InerMod.iner_hello(123)

# you can't change variables in another module
MyMod.mymod_abc = "def"



#=
------------------------------------------------------------
                    Using external libraries
------------------------------------------------------------
In julia there are two (three) ways to load external code.
1. `import` keyword
2. `using` keyword
3. `include` function
=#

# we can use import or using
import .MyMod.InerMod # needs a dot (package manager later)
InerMod.iner_hello("name")

using .MyMod.InerMod2
iner_hello("name")
iner_abc # error, still undefined, only hello was exported
InerMod2.iner_abc # this works

using .MyMod: mymod_abc # load only some things
mymod_abc # works
mymod_public_abc # dosen't work

# just execute the code from a given file
include("hello_world.jl")

# now let's do the same with some standard library
A = rand(3, 3)
det(A) # error

import LinearAlgebra
LinearAlgebra.det(A)
det(A) # still an error

using LinearAlgebra: det
det(A) # works
eigen(A) # dosen't work

using LinearAlgebra
eigen(A) # works



#=
------------------------------------------------------------
                    PackageManager
------------------------------------------------------------
Julias' package manager is writen in Julia itself.
So it can be imported just like any other package
=#
import Pkg
Pkg.status()

# for interactive use of the PackageManager press: ]
# now type commands for the package manger
# start with "help"
# to exit the package manager press: "BackSpace"
pkg> help

# install a package and use it
pkg> add Example
julia> import Example
julia> Example.hello("abc")

# list your enviorment
pkg> status
#=
You will see someting like this:
Status `~/.julia/environments/v1.8/Project.toml`
  [7876af07] Example v0.5.3
( ... more packages if you have them ...)
=#

# remove a package
pkg> rm Example
julia> import Example # now dosen't work
pkg> status
#= Oputput (may look different depending on your enviorment):
Status `~/.julia/environments/v1.8/Project.toml` (empty project)
=#

# Finally install all packages you will need for further tasks
pkg> add DataFrames CSV GLM Plots DifferentialEquations Symbolics ModelingToolkit Integrals

