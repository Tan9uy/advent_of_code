use std::fs;

fn main() {
    // read file
    let contents = fs::read_to_string("../inputs/input_1.txt")
        .expect("Should have been able to read the file");

    // split to get each elve
    let elves = contents.split("\n\n");

    // list the elves calories
    let mut sum_list: Vec<i32> = elves
        .map(|elve| {
            let sum: i32 = elve
                .split("\n")
                .map(|string| {
                    // parse the number
                    if string.is_empty() {
                        return 0;
                    } else {
                        let calories: i32 = string.parse().unwrap();
                        return calories;
                    }
                })
                .sum::<i32>();
            return sum;
        })
        .collect::<Vec<i32>>();

    // sort by reverse the elves calories
    sum_list.sort_by(|a, b| b.cmp(a));

    //  get the three last elves
    let max_elves: &[i32] = &sum_list[0..3];

    // sum the values
    let res: i32 = max_elves.iter().sum();

    println!("{}", max_elves[0]);
    println!("{}", res);
}
