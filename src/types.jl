# module Bach

using Mods: Mods

# https://en.wikipedia.org/wiki/Pitch_class
const PC = Mods.Mod{12}

struct Fundamental
    pc::PC
end

# module Bach
