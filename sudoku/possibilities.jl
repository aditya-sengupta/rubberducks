function possibilities(s::Sudoku, i, j)
    if s.grid[i,j] != 0
        return [s.grid[i,j]]
    end
    values = 1:9
    values = setdiff(values, s.grid[i,:])
    values = setdiff(values, s.grid[:,j])
    tli, tlj = topleft(i), topleft(j)
    values = setdiff(values, s.grid[tli:tli+2, tlj:tlj+2])
    values
end