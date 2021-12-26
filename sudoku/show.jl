function show(io::IO, s::Sudoku)
    println("  -----   -----   -----")
    for (i, r) in enumerate(eachrow(s.grid)) # counts up and returns each row in the matrix
        print("| ") # left border
        for (j, v) in enumerate(r)
            print((v > 0 ? string(v) : "-") * " ") # print '-' for incomplete elements and the number otherwise
            if j % 3 == 0
                print("| ") # condition 2
            end
        end
        println() # condition 1
        if i % 3 == 0
            println("  -----   -----   -----") # condition 3
        end
    end
end