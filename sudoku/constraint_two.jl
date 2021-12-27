function constraint_one(s::Sudoku)
    change = false
    for i in 1:9
        for j in 1:9
            if s.grid[i, j] == 0
                poss = possibilities(s, i, j)
                if length(poss) == 1
                    s.grid[i,j] = poss[1]
                    change = true
                end
            end
        end
    end
    change
end

function constraint_two(s::Sudoku)
    change = false
    possibilities_matrix = hcat([[possibilities(s, i, j) for i in 1:9] for j in 1:9]...)

    for gen in (Base.eachrow, Base.eachcol, eachblock)
        for (possibilities_vector, grid_vector) in zip(gen(possibilities_matrix), gen(s.grid))
            fishing = [findall(k in x for x in possibilities_vector) for k in 1:9] # indices where the value at index could be
            knowns = Dict{Int64,Int64}() # maps index to its known value
            for (l, f) in enumerate(fishing)
                if length(f) == 1
                    knowns[f[1]] = l
                end
            end
            vacancies = findall(x -> x == 0, grid_vector) # all the indices we need to fill in
            newlocs = intersect(vacancies, keys(knowns))
            if length(newlocs) > 0
                for n in newlocs
                    grid_vector[n] = knowns[n]
                    change = true
                end
            end
        end
    end

    change
end