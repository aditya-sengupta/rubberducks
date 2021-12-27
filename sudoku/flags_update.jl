function update!(s::Sudoku, flags::AbstractArray{Bool, 3}, index::Tuple{Int64,Int64})
    val = s.grid[index...]
    @assert val > 0
    flags[index[1], 1:9, val] .= false # nothing in the row can be 'val'
    flags[1:9, index[2], val] .= false # nothing in the col can be 'val'
    flags[blockof(index...)..., val] .= false # nothing in the block can be 'val'
    flags[index..., 1:9] .= false # this index can't be anything
    flags[index..., val] = true # except for the value we just found
    # check that we didn't rule out all the possibilities for some value being in a row, col, or block
    for (desc, gen) in zip(("row", "col", "block"), (eachrow, eachcol, eachblock))
        for (i, subset) in enumerate(gen(flags))
            checkrow = vec(sum(subset, dims=1)) .== 0
            checkcol = vec(sum(subset, dims=2)) .== 0

            if any(checkrow)
                inds = findall(checkrow)
                throw("Inconsistent state in $desc $i: indices $inds have no possible values")
            end
            if any(checkcol)
                inds = findall(checkcol)
                throw("Inconsistent state in $desc $i: values $inds have no possible indices")
            end
        end
    end
end
