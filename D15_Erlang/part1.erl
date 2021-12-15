% Part 1, not efficient at all, use Map instead
part1Helper(Lines, Best, Acc) ->
    if
        Acc >= Best -> Best;
        true -> case Lines of % Going through the rows
            [R | []] -> case R of % Bottom row
                [C | []] -> min(Best, Acc + C); % Bottom right corner
                [C | CS] -> part1Helper([CS], Best, Acc + C); % Go right
                _ -> error("Out of array")
            end;
            [R | RS] -> case R of % Going through the columns
                [C | []] -> part1Helper(RS, Best, Acc + C); % Right column, go down
                [C | _]  ->  % We have a choice
                    Down = part1Helper(RS, Best, Acc + C),
                    part1Helper(dropCol(Lines), min(Down, Best), Acc + C);
                _ -> error("Out of array")
            end;
            _ -> error("Out of array")
        end
    end.

part1(Lines) -> part1Helper(Lines, length(Lines) * length(lists:nth(1, Lines)) * 9, 0).
