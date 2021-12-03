use crate::{file_to_array, Position};

/// Generate the final position for part 2
fn merge_lines_to_pos(lines: Vec<String>) -> Position {
    let mut pos = Position { depth: 0, horiz: 0 };
    let mut aim: u32 = 0;
    for line in lines {
        if line.is_empty() {
            continue;
        }

        let components: Vec<&str> = line.split(" ").collect();
        let op = components[0];
        let dist = components[1].parse::<u32>().unwrap();
        match op {
            "up" => aim -= dist,
            "down" => aim += dist,
            "forward" => {
                pos.horiz += dist;
                pos.depth += aim * dist;
            },
            _ => panic!("Invalid submarine operation: `{}`", op),
        }
    }
    return pos;
}

/// Main function for part 1
pub fn main() {
    let lines = file_to_array("./input");
    let pos = merge_lines_to_pos(lines);
    println!("Depth: {}", pos.depth);
    println!("Horizontal: {}", pos.horiz);
    println!("Product: {}", pos.depth * pos.horiz);
}
