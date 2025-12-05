use std::fs;
fn solution(lines: Vec<&str>, order: bool) {
    let mut stacks: [Vec<char>; 9] = Default::default();

    // Parse the stacks
    for line in lines[0..8].iter().rev() {
        let chars_list = line.chars().collect::<Vec<char>>();
        for k in 0..9 {
            if !chars_list[k * 4 + 1].is_whitespace() {
                stacks[k].push(chars_list[k * 4 + 1]);
            }
        }
    }

    for line in lines[10..].iter() {
        // parse each line a move the items from src to dst
        let words = line.split(' ').collect::<Vec<&str>>();
        let howmany: usize = words[1].parse().unwrap();
        let src: usize = words[3].parse::<usize>().unwrap() - 1;
        let dst: usize = words[5].parse::<usize>().unwrap() - 1;

        if order {
            let mut tmp = Vec::new();
            for _ in 0..howmany {
                let n = stacks[src].pop();
                if n.is_none() {
                    continue;
                }
                tmp.push(n.unwrap());
            }
            for _ in 0..tmp.len() {
                let n = tmp.pop();
                if n.is_none() {
                    continue;
                }
                stacks[dst].push(n.unwrap());
            }
        } else {
            for _ in 0..howmany {
                let n = stacks[src].pop();
                if n.is_none() {
                    continue;
                }
                stacks[dst].push(n.unwrap());
            }
        }
    }

    let mut res: Vec<char> = Vec::new();
    for i in 0..stacks.len() {
        res.push(stacks[i].pop().unwrap());
    }
    println!("{}", res.iter().collect::<String>());
}

fn main() {
    // read file
    let contents = fs::read_to_string("../inputs/input_5.txt")
        .expect("Should have been able to read the file");

    let lines: Vec<&str> = contents.lines().collect();

    solution(lines.clone(), false);
    solution(lines.clone(), true);
}
