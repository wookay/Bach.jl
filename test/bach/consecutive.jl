module test_bach_consecutive

using Test
using Bach: consecutive

@test isempty(consecutive([]))
@test collect(consecutive([])) == []

@test_throws DomainError consecutive([5])

@test collect(consecutive([5, 6, 7])) == [(5, 6), (6, 7)]

end # module test_bach_consecutive
