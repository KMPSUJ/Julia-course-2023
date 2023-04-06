#=
------------------------------------------------------------
                    Plotting
------------------------------------------------------------
This section assumes the usage of Plots.jl.
There are other packages like Makie.jl which may be
as good or even better (just pick one and use it).

Generally you can use plot and plot! for anything.
Plots.jl uses magic keyword arguments to costomize your plot.
=#

using Plots
# Plots are not showing by default, so change it
# or invoke gui()
# or pass show=true to the plot function
default(:show, true)

# get some random data
x = range(-1, 1, length=20)
y = rand(20)

# function to plot anything: plot
plot(x, y)
plot(sin)
plot(sin, 2π, 4π)
plot(x, exp)

# draw something different than a line
plot(x, y, seriestype=:scatter)
plot(randn(10_000), seriestype=:histogram)
plot(x, y, st=:sticks)

# 3d data
plot(x, x, (t, s) -> exp(-t^2 - s^2), st=:surface)
plot(randn(10_000), randn(10_000), st=:histogram2d)

# you can use an alias instaed of seriestype
scatter(x, y)
histogram(randn(10_000))

# other options can be passed as optional arguments
plot(x, y, label="some data", title="First plot", lc=:red, mc=:blue, mark=:square)

# plot! or generally "!" is used to modify the plot
plot!(cos)
plot!(title="Title with plot!")
title!("Title with title!")
xlabel!("x axis")
ylabel!("y axis")

# save figure (different formats available)
savefig("someplot.png")
