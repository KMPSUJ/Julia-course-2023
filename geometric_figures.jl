"""
`AbstractFigure` is an abstract type for geometric figures.
All subtypes of AbstractFigure should have those methods implemented:
 - `is_point_in(f::AbstractFigure, x::Real, y::Real)::Bool`
 - `edge_approx(f::AbstractFigure)::Matrix{Float64}`
"""
abstract type AbstractFigure end

"""
`Circle` implements a circle.
Is subtype of `AbstractFigure`.
"""
struct Circle<:AbstractFigure
	# (x,y) is the center
	x::Real
	y::Real
	r::Real
end

is_point_in(f::Circle, x::Real, y::Real)::Bool = sqrt((f.x - x)^2 + (f.y - y)^2) <= f.r

function edge_approx(f::Circle)::Matrix{Float64}
        angle_range = range(0, 2pi, length=100)
	x_approx = f.x .+ f.r .* cos.(angle_range)
	y_approx = f.y .+ f.r .* sin.(angle_range)
	return hcat(x_approx, y_approx)
end

"""
`Rectangle` implements a rectangle.
Is subtype of `AbstractFigure`.
"""
struct Rectangle<:AbstractFigure
	# (x,y) is bottom left corner
	# edge_hor is the length of the horizontal edge
	# edge_ver is the length of the vertical edge
	x::Real
	y::Real
	edge_hor::Real
	edge_ver::Real
end

function is_point_in(f::Rectangle, x::Real, y::Real)::Bool
	return (f.x <= x <= f.x + f.edge_hor) && (f.y <= y <= f.y + f.edge_ver)
end

function edge_approx(f::Rectangle)::Matrix{Float64}
	horizontal = range(f.x, f.x + f.edge_hor, length=25)
	vertical = range(f.y, f.y +f.edge_ver, length=25)
	bottom = hcat(horizontal, fill(f.y, 25))
	top = hcat(horizontal, fill(f.y + r.edge_ver, 25))
	left = hcat(fill(f.x, 25), vertical)
	right = hcat(fill(f.x + f.edge_hor, 25), vertical)
	return vcat(bottom, top, left, right)
end


# Figure list
FigureList = Vector{T} where T<:AbstractFigure

is_point_in(f::FigureList, x::Real, y::Real)::Bool = any(is_point_in.(f, x, y))

function edge_approx(f::FigureList)::Matrix{Float64}
	return vcat(edge_approx.(f)...)
end


# check if two figures are overlapping
function overlapping(f1::Union{AbstractFigure, FigureList}, f2::Union{AbstractFigure, FigureList})::Bool
	edge1 = edge_approx(f1)
	edge2 = edge_approx(f2)
        # check if f1 is laying in f2
        f1_in_f2 = any([is_point_in(f2, edge1[t, 1], edge1[t, 2]) for t in 1:size(edge1, 1)])
        # check if f2 is laying in f1
        f2_in_f1 = any([is_point_in(f1, edge2[t, 1], edge2[t, 2]) for t in 1:size(edge2, 1)])
        return f1_in_f2 || f2_in_f1
end

function overlapping(f1::Circle, f2::Circle)::Bool
	return (f1.x - f2.x)^2 + (f1.y - f2.y)^2 <= (f1.r + f2.r)^2
end