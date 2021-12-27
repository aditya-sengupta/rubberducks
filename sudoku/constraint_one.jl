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
