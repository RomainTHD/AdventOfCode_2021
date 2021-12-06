#!/usr/bin/ruby
# Part 1

# Day count for part 1
DAY_COUNT_P1 = 80

# Part 1, here we don't really care we do it the dumb way, aka really pushing to the array
# @param [Array] fishes Fishes initial array
# @return [Integer] Number of fishes
def part1(fishes)
    raise "Argument error" unless fishes.kind_of?(Array)

    (1..DAY_COUNT_P1).each do |_|
        nb_to_add = 0
        fishes.each_with_index do |fish, idx|
            if fish == 0
                fishes[idx] = RESET_AGE
                nb_to_add += 1
            else
                fishes[idx] -= 1
            end
        end

        (1..nb_to_add).each do |_|
            fishes.push(INITIAL_AGE)
        end
    end

    fishes.size
end
