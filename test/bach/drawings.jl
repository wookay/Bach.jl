module test_bach_karnak

using Test
using Bach # draw_graph animate_graph
using Bach: AnimatedGif
using Graphs # SimpleDiGraph

g = SimpleDiGraph(UInt8(2))

d = draw_graph(g)
svg = sprint(Base.show, MIME("image/svg+xml"), d)
@test endswith(svg, "</svg>\n")

a = animate_graph(g)
@test a isa AnimatedGif

add_edge!(g, 1, 3)
a = animate_graph(g)

end # module test_bach_karnak
