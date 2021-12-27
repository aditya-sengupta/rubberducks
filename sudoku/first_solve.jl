function solve(s::Sudoku)
    change = true
    solution = Base.copy(s)
    while change
        change = false
        change = change && constraint_one(solution)
        change = change && constraint_two(solution)
    end
    solution
end