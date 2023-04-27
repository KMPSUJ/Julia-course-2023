#=
In this file:
 - Basics
 - load from CSV
 - fit linear model
 - some joins filters
=#


#=
------------------------------------------------------------
            Constructors, Indexing, Basics
------------------------------------------------------------
=#
using DataFrames, Plots, GLM, Statistics, LinearAlgebra
using CSV: CSV

# the basic structure to work with is: DataFrame
df = DataFrame(:A => 1:10, :B => Char.(97:106))

# indexing
df.A # view
df[!, :A] # view
df[:, :A] # copy

# instead of Symbols you can use Strings or numbers
df[!, 1] === df[!, "A"] === df[!, :A]

# to add a column
df.C = [i^2 for i in 1:10]

# to add a row
append!(df, (11, 'k',121))

# get the names of columns
names(df)
names(df, Int) # show only those with Int values
names(df, r"[C-K]") # only matching a regular expression

# get the dimensions of the DataFrame
size(df)
size(df, 1) # rows
size(df, 2) # columns

# basically you can do with DataFrames everything you would do with Arrays
for i in df.C
    println(i)
end

for i in 1:size(df, 1) # for each row
    println("A: $(df[i, :A]), B: $(df[i, "B"]), C: $(df.C[i])")
end



#=
------------------------------------------------------------
                Read, Write to CSV
------------------------------------------------------------
=#
df = CSV.read("data/marki.txt", DataFrame)

CSV.write("content_of_df.csv", DataFrame(:A => 1:3, :B => 2:4))



#=
------------------------------------------------------------
                Select, Join, Filter
------------------------------------------------------------
=#
df = CSV.read("data/pogoda.txt", DataFrame)

# standard syntax (just select)
select(df, :Dzien, :Opad, :Temperatura)
select(df, :Dzien, 4:5)
# Not selector
select(df, Not(:Opad))
# regex also works
select(df, :Dzien, r"chmur")

# select and do something
# INPUT_SELECTOR => OPERATION => OUTPUT_NAME

select(df, :Dzien => mean => :MeanDay)

# second or third part may be skiped
select(df, :Dzien => :Day)
select(df, :Dzien => mean)

# more then one input column
select(df, :Dzien, :Opad, [:Dzien, :Opad] => dot => :Dzien_dot_Opad)
select(df, :Dzien, :Opad, [:Dzien, :Opad] => ByRow(*) => :Dzien_times_Opad)


dfm = CSV.read("data/marki.txt", DataFrame)
dfp = CSV.read("data/perfumy.txt", DataFrame)


