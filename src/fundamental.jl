# module Bach

# https://en.wikipedia.org/wiki/Pitch_class
const PC = Mods.Mod{12}

struct Fundamental
    pc::PC
end
Fundamental(note::Note) = Fundamental(PC(note.pitch))

# module Bach
