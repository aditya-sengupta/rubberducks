struct Sudoku
    grid::MMatrix{9,9,Int64} # the first “M” is for “Mutable”
    # i.e. I can change the values in the grid as I go
end