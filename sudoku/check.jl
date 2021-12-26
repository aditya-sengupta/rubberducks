function check(region; type="region", verbose=true)
    if length(Set(region)) < 9 && !(0 in region)
        if verbose
            println("Found $(type) without all of 1-9.")
        end
        return false
    end
    return true
end

function check(s::Sudoku; verbose=true)
    solved = true

    for (desc, eachregion) in zip(("row", "col", "block"), (eachrow, eachcol, eachblock))
        for region in eachregion(s.grid)
            solved = solved && check(region; type=desc, verbose=verbose)
        end
    end

   solved
end