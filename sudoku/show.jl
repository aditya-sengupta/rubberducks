function show(io::IO, s::Sudoku)
    println("  -----   -----   -----")
    for (i, r) in enumerate(eachrow(s.grid))
        print("| ")
        for (j, v) in enumerate(r)
            print((v > 0 ? string(v) : "-") * " ")
            if j % 3 == 0
                print("| ")
            end
        end
        println()
        if i % 3 == 0
            println("  -----   -----   -----")
        end
    end
end