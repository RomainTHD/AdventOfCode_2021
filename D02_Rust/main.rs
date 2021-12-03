use std::fs;

mod part1;
mod part2;

/// Submarine position
struct Position {
    /// Submarine depth
    depth: u32,
    /// Submarine horizontal component
    horiz: u32,
}
// 32 bits are needed for the final multiplication

/// Read a file and transforms it to an array of lines
fn file_to_array(path: &str) -> Vec<String> {
    let data = fs::read_to_string(path).expect("File not found").to_string();
    let lines = data.split("\n").map(String::from).collect();
    return lines;
}

/// Main function
pub fn main() {
    println!("Part 1");
    part1::main();
    println!("Part 2");
    part2::main();
}
