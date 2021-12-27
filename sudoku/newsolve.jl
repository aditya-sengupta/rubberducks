function solve!(s::Sudoku)
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
            return s
       end
       last_num_found = sum(mask(s))
   end
   @assert check(s)
   # the only way you should get here without causing an error further up should be if you've got a completed puzzle
   s
end