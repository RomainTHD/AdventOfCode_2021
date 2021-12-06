#!/usr/bin/ruby
# Part 2

# Day count for part 2
DAY_COUNT_P2 = 256

# Part 2, smarter, we only keep the number of fishes, which makes this algorithm O(1) in space complexity
# @param [Array] fishes_init Fishes initial array
# @return [Integer] Number of fishes
def part2(fishes_init)
    raise "Argument error" unless fishes_init.kind_of?(Array)

    fishes_to_add = Array.new(INITIAL_AGE, 0)

    fishes_init.each do |fish|
        fishes_to_add[fish] += 1
    end

    (1..DAY_COUNT_P2).each do |_|
        nb_to_add = fishes_to_add[0]

        (1..fishes_to_add.size - 1).each do |i|
            fishes_to_add[i - 1] = fishes_to_add[i]
        end

        fishes_to_add[INITIAL_AGE] = nb_to_add
        fishes_to_add[RESET_AGE] += nb_to_add
    end

    fish_count = 0
    fishes_to_add.each do |nb_fish|
        fish_count += nb_fish
    end

    fish_count
end
