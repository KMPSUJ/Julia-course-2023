
#=
In this file:
 - activate (enviorments with Pkg)
=#

#=
------------------------------------------------------------
                    Enviorments with Pkg
------------------------------------------------------------
=#

# First install a package as it was shown in
# the file about Package Maneger
pkg> add Example

# list your enviorment
pkg> status
#=
You will see someting like this:
Status `~/.julia/environments/v1.8/Project.toml`
  [7876af07] Example v0.5.3
( ... more packages if you have them ...)
=#

# The package was installed in the global(main) enviorment.
# Now try to use a separate enviorment.
# Three methods are proposed (chose on)
# Other are shown to make you learn some new things

# Option 1
# use other tools to make a directory (filemanager, shell)
# then activate that enviorment
pkg> activate /path/to/your/enviorment/directory

# Option 2
# use the shell emulator
# I don't know how(if) it works on Windows ???
shell> eval [ -d ~/JuliaCourse2023 ] || mkdir ~/JuliaCourse2023
shell> cd ~/JuliaCourse2023
pkg> activate .

# insted of `cd ~/JuliaCourse2023` you can
# use `activate ~/JuliaCourse2023`
# this won't change the working directory

# Option 3
# using julia functions
julia> mkdir("JuliaCourse2023")
pkg> activate JuliaCourse2023

# No matter which method you used
# the active enviorment has changed
pkg> status
#= Oputput (may look different depending on your env's path):
Status `~/JuliaCourse2023/Project.toml` (empty project)
=#

# try to add a package
# pick somenting which isn't present in your main enviorment
pkg> add JSON
pkg> status
#= Oputput:
Status `~/JuliaCourse2023/Project.toml`
  [682c06a0] JSON v0.21.3
=#

# Importing JSON will work
# Importing Example will work (packages from main enviorment are avialable)
# but not vice versa
julia> using JSON, Example # works
# switch back to main enviorment
pkg> activate
julia> using JSON # error

