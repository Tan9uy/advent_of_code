use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;

fn read_lines<P>(filename: P) -> io::Result<io::Lines<io::BufReader<File>>>
where
    P: AsRef<Path>,
{
    let file = File::open(filename)?;
    Ok(io::BufReader::new(file).lines())
}

fn main() {
    // part 1
    if let Ok(lines) = read_lines("../inputs/input_2.txt") {
        let res: i32 = lines
            .map(|line| {
                return match line.expect("REASON").to_string().as_ref() {
                    "A X" => 3 + 1,
                    "B X" => 0 + 1,
                    "C X" => 6 + 1,
                    "A Y" => 6 + 2,
                    "B Y" => 3 + 2,
                    "C Y" => 0 + 2,
                    "A Z" => 0 + 3,
                    "B Z" => 6 + 3,
                    "C Z" => 3 + 3,
                    _ => 0,
                };
            })
            .sum::<i32>();
        println!("{}", res.to_string());
    }
    // part 2
    if let Ok(lines) = read_lines("../inputs/input_2.txt") {
        let res: i32 = lines
            .map(|line| {
                return match line.expect("REASON").to_string().as_ref() {
                    "A Z" => 6 + 2,
                    "B Z" => 6 + 3,
                    "C Z" => 6 + 1,
                    "A Y" => 3 + 1,
                    "B Y" => 3 + 2,
                    "C Y" => 3 + 3,
                    "A X" => 0 + 3,
                    "B X" => 0 + 1,
                    "C X" => 0 + 2,
                    _ => 0,
                };
            })
            .sum::<i32>();
        println!("{}", res.to_string());
    }
}
