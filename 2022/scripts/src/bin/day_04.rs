use std::fs;

fn main() {
    // read file
    let contents = fs::read_to_string("../inputs/input_4.txt")
        .expect("Should have been able to read the file");

    // part 1
    let res: i32 = contents
        .split("\n")
        .map(|line| {
            let [a, b, c, d]: [i32; 4] = line
                .split(['-', ','])
                .map(|n| n.parse().unwrap())
                .collect::<Vec<i32>>()
                .try_into()
                .unwrap();
            return ((a >= b && c <= d) || (a <= b && c >= d)) as i32;
        })
        .sum::<i32>();
    println!("{}", res.to_string());

    // part 2
    let res: i32 = contents
        .split("\n")
        .map(|line| {
            let [a, b, c, d]: [i32; 4] = line
                .split(['-', ','])
                .map(|n| n.parse().unwrap())
                .collect::<Vec<i32>>()
                .try_into()
                .unwrap();
            return (!(a > d || b < c)) as i32;
        })
        .sum::<i32>();
    println!("{}", res.to_string());
}
