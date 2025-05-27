module test_bach_fundamental

using Test
using Bach: Fundamental
using Mods: Mods
using MIDI: MIDI, Note, name_to_pitch

n1 = Note(name_to_pitch("C4"), 0)
fm = Fundamental(n1)
@test MIDI.PITCH_TO_NAME[Mods.value(fm.pc)] == "C"

end # module test_bach_fundamental
