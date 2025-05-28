# module Bach

# from julia/base/iterators.jl

struct Consecutive{I}
    itr::I
end

function consecutive(iter::I)::Consecutive{I} where I
    length(iter) == 1 && throw(DomainError("iter can't be 1 element."))
    Consecutive{I}(iter)
end

function Base.length(c::Consecutive{I}) where I
    if isempty(c.itr)
        return 0
    else
        return length(c.itr) - 1
    end
end

function Base.eltype(::Type{Consecutive{I}}) where I
    T = eltype(I)
    Tuple{T, T}
end

function Base.iterate(c::Consecutive{I}, i::Int=1) where I
    if 1 <= i <= length(c)
        ((c.itr[i], c.itr[i+1]), i + 1)
    else
        nothing
    end
end

function Base.lastindex(c::Consecutive{I}) where I
    length(c)
end

# module Bach
