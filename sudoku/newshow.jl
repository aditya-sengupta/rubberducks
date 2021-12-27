mask(s::Sudoku) = (sum(s.flags, dims=3) .== 1)[:,:,1]

function show(io::IO, s::Sudoku)
    grid = sum([k .* s.flags[:,:,k] for k in 1:9]) .* mask(s)
    println("  -----   -----   -----")
    for (i, r) in enumerate(eachrow(grid))
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