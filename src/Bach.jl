module Bach

export consecutive
include("consecutive.jl")

export PC, Fundamental
include("types.jl")
include("fundamental.jl")

export draw_graph, animate_graph
include("drawings/karnak.jl")
include("drawings/luxor.jl")

end # module Bach
