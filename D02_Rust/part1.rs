use crate::{file_to_array, Position};

/// Generate the final position for part 1
fn merge_lines_to_pos(lines: Vec<String>) -> Position {
    let mut pos = Position { depth: 0, horiz: 0 };
    for line in lines {
        if line.is_empty() {
            continue;
        }

        let components: Vec<&str> = line.split(" ").collect();
        let op = components[0];
        let dist = components[1].parse::<u32>().unwrap();
        match op {
            "forward" => pos.horiz += dist,
            "down" => pos.depth += dist,
            "up" => pos.depth -= dist,
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
