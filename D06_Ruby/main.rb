#!/usr/bin/ruby
# Main

require_relative "part1"
require_relative "part2"

# Initial age when created
INITIAL_AGE = 8

# Age when reset
RESET_AGE = 6

# Load the data
# @param [String] file_name File path
# @return [Array] Data loaded
def load_data(file_name)
    file = File.open(file_name, "r")
    data_str = file.read
    file.close
    data_arr = data_str.split(",")

    fishes = Array.new
    data_arr.each do |fish|
        fishes.push(fish.to_i)
    end

    fishes
end

# Main function
# @return [nil]
def main
    puts "Part 1:"
    fishes = load_data("input")
    puts part1(fishes)

    puts "Part 2:"
    fishes = load_data("input") # Resets the data the hard way
    puts part2(fishes)

    puts "OK"
end

main
