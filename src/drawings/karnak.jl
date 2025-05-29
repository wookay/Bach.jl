# module Bach

using Karnak: Karnak
using .Karnak: Luxor
using .Luxor: Drawing, origin, sethue, finish, preview
using .Luxor: slope, between, arrow, text, midpoint
using .Luxor: fontface, background
using .Luxor: Movie, Scene, AnimatedGif
using MIDI
using Graphs # SimpleDiGraph edges

function vertex_labels_func(vertex::UInt8)
    pc = vertex - 1
    MIDI.PITCH_TO_NAME[pc]
end

function vertex_label_text_colors_func(vertex::UInt8)
    "white"
end

function edge_arrows_func(edge_n, edge_src, edge_dst, from, to)
    sethue(Luxor.Colors.HSL(230, 0.8, 0.6))
    s = slope(from, to)
    arrow(
        between(from, to, 0.10),
        between(from, to, 0.88),
        [s, s],
        startarrow = false,
        finisharrow = true,
        :stroke,
        linewidth = 0.7,
        arrowheadlength = 7)
end

function edge_labels_func(edge_n, edge_src, edge_dst, from, to)
    name_src = vertex_labels_func(edge_src)
    name_dst = vertex_labels_func(edge_dst)
    text(string(name_src, " → ", name_dst), midpoint(from, to))
end

global frame_framenumber::Int = 0
function frame_edge_arrows_func(edge_n, edge_src, edge_dst, from, to)
    global frame_framenumber
    if frame_framenumber == edge_n
        edge_arrows_func(edge_n, edge_src, edge_dst, from, to)
    end
end

function frame_edge_labels_func(edge_n, edge_src, edge_dst, from, to)
    global frame_framenumber
    if frame_framenumber == edge_n
        edge_labels_func(edge_n, edge_src, edge_dst, from, to)
    end
end

function draw_body(g::SimpleDiGraph; framenumber::Union{Nothing, Int})
    sethue("black")
	fontface("Menlo") # Monaco"
	background("yellow3")
    f_vertexlabels = vertex_labels_func
    f_vertexlabeltextcolors = vertex_label_text_colors_func
    if framenumber === nothing
        f_edge_arrows = edge_arrows_func
        f_edge_labels = edge_labels_func
    else
        global frame_framenumber
        frame_framenumber = framenumber
        f_edge_arrows = frame_edge_arrows_func
        f_edge_labels = frame_edge_labels_func
    end
    Karnak.drawgraph(g,
        vertexlabels = f_vertexlabels,
        vertexlabeltextcolors = f_vertexlabeltextcolors,
        vertexshapesizes = 10,
        edgearrows = f_edge_arrows,
        edgelabels = f_edge_labels)
end

function draw_graph(g::SimpleDiGraph; width::Float64 = 200.0, height::Float64 = 200.0)::Drawing
    Drawing(width, height, :svg)
    origin()
    draw_body(g; framenumber = nothing)
    finish()
    preview()
end

# easingfunction
#    lineartween, easeinquad, easeoutquad, easeinoutquad,
#    easeincubic, easeoutcubic, easeinoutcubic, easeinquart,
#    easeoutquart, easeinoutquart, easeinquint, easeoutquint,
#    easeinoutquint, easeinsine, easeoutsine, easeinoutsine,
#    easeinexpo, easeoutexpo, easeinoutexpo, easeincirc,
#    easeoutcirc, easeinoutcirc, easingflat,
#    easeinoutinversequad, easeinoutbezier,
function animate_graph(g::SimpleDiGraph ;
                       width::Float64 = 200.0,
                       height::Float64 = 200.0,
                       framerate = 30,
                       easingfunction = Luxor.easeinquad)
    movie = Movie(width, height, "animate")
    scenelist = Vector{Scene}()
    note_edges = edges(g)
    if isempty(note_edges)
    else
        len = length(note_edges)
        for (idx, edge) in enumerate(note_edges)
            scene = Scene(movie, frame, idx:idx)
            push!(scenelist, scene)
        end
    end
    a = animate_gif(g,
                    movie,
                    scenelist ;
                    creategif = true,
                    framerate = framerate,
                    debug = false)
    a
end

function frame(g::SimpleDiGraph, scene::Scene, framenumber)
    draw_body(g; framenumber = framenumber)
end

# module Bach
