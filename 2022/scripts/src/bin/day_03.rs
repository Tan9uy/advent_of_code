use std::fs;

fn main() {
    // read file
    let contents = fs::read_to_string("../inputs/input_3.txt")
        .expect("Should have been able to read the file");

    let order: Vec<char> = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        .chars()
        .collect();

    // part 1
    let res: i32 = contents
        .split("\n")
        .map(|line| {
            let chars_vect: Vec<char> = line.to_string().chars().collect();
            let size: usize = chars_vect.len() / 2;
            let mut priority: i32 = 0;

            // find the item in the both rucksacks
            for idx in size..(size * 2) {
                if chars_vect[0..size].iter().find(|&&x| x == chars_vect[idx]) != None {
                    priority =
                        (order.iter().position(|&x| x == chars_vect[idx]).unwrap() + 1) as i32;
                    break;
                }
            }
            return priority;
        })
        .sum::<i32>();
    println!("{}", res.to_string());

    // part 2
    let contents = fs::read_to_string("../inputs/input_3.txt")
        .expect("Should have been able to read the file");
    let lines: Vec<Vec<char>> = contents.split("\n").map(|a| a.chars().collect()).collect();
    let mut i = 0;
    let mut priorities: i32 = 0;
    while i < lines.len() {
        // find the vec of items that are present in 2 lines
        let mut items = Vec::new();
        for idx in 0..lines[i].len() {
            if lines[i + 1].iter().find(|&&x| x == lines[i][idx]) != None {
                items.push(lines[i][idx]);
            }
        }
        // check with previous vec and the last line which letter we are looking for
        for c in items {
            if lines[i + 2].iter().find(|&&x| x == c) != None {
                priorities += (order.iter().position(|&x| x == c).unwrap() + 1) as i32;
                break;
            }
        }
        i += 3;
    }
    println!("{}", priorities.to_string());
}
