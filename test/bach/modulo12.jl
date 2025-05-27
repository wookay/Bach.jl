module test_bach_modulo12

using Test
using Bach: PC
using Mods: Mod

@test PC(1) isa Mod{12}
@test PC(1) + 12 == PC(1)
@test PC(1) + PC(11) == PC(0)

end # module test_bach_modulo12
