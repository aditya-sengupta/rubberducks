function solve!(s::Sudoku; depth=0, maxdepth=3)
    last_num_found = sum(mask(s))
    while last_num_found < 81
        # for each (row, column, block), is there only one possible place a certain value could go?
        for (desc, gen) in zip(("row", "col", "block"), (eachrow, eachcol, eachblock))
            for (num, possibilities) in enumerate(gen(s.flags))
                # "possibilities" is a 9x9: (i, j) is "could position i in the row (resp. column, block) be value j?"
                fishing = (sum(possibilities, dims=1) .== 1) .* possibilities
                for idx in findall(fishing)
                    # println("$desc $num's only possible location for $val is $n")
                    update!(s.flags, indexof(desc, num, idx[1]), idx[2])
                end
            end
        end

        if sum(mask(s)) == last_num_found # we didn't find anything new this iteration
                if depth < maxdepth
                return solve_guess(s, depth, maxdepth)
                else
                return s
                end
        end
        last_num_found = sum(mask(s))
    end
    @assert check(s)
    # the only way you should get here without causing an error further up should be if you've got a completed puzzle
    s
end

function solve_guess(s::Sudoku, depth, maxdepth)
    if check(s)
        return s
    end
    nums_poss = vec(sum(s.flags, dims=3)[:,:,1])
    where_to_guess = sortperm(nums_poss)
    start_sort = findfirst(x -> x == findfirst(nums_poss .== minimum(nums_poss[nums_poss .> 1])), where_to_guess)
    idx = where_to_guess[start_sort:end]
    guessed_sudoku = copy(s)
    for idx in where_to_guess
        i, j = (idx - 1) % 9 + 1, ((idx - 1) ÷ 9) + 1
        possible_guesses = findall(s.flags[i, j, :])
        for guess in possible_guesses            
            try
                update!(guessed_sudoku.flags, (i, j), guess)
                solution = solve!(guessed_sudoku; depth=depth+1, maxdepth=maxdepth)
                if check(solution)
                    return solution 
                end
            catch
                guessed_sudoku = copy(s)
            end
        end
    end
    throw("Ran through all guesses to depth=$maxdepth without reaching a solution.")
end