fn is_visible(matrix: &Vec<Vec<usize>>, row: usize, col: usize) -> bool {
    let value = matrix[row][col];
    // look a the left
    if matrix[row].iter().take(col).max().unwrap() < &value {
        return true;
    }
    // look a the rigth
    if matrix[row].iter().skip(col + 1).max().unwrap() < &value {
        return true;
    }
    // look at the top
    if matrix.iter().map(|item| item[col]).take(row).max().unwrap() < value {
        return true;
    }
    // look at the bottom
    if matrix
        .iter()
        .map(|item| item[col])
        .skip(row + 1)
        .max()
        .unwrap()
        < value
    {
        return true;
    }
    return false;
}

fn tree_distance(trees: Vec<usize>, value: usize) -> usize {
    for (idx, tree) in trees.iter().enumerate() {
        if tree >= &value {
            return idx + 1;
        }
    }
    return trees.len();
}

fn score(matrix: &Vec<Vec<usize>>, row: usize, col: usize) -> usize {
    let value = matrix[row][col];
    // look a the left
    let mut trees = matrix[row][0..col].to_vec();
    trees.reverse();
    let left_score = tree_distance(trees, value);
    // look a the rigth
    let right_score = tree_distance(matrix[row][col + 1..].to_vec(), value);
    let mut new_col: Vec<usize> = Vec::new();
    matrix.iter().for_each(|item| new_col.push(item[col]));
    // look at the bottom
    let bottom_score = tree_distance(new_col[row + 1..].to_vec(), value);
    // look at the top
    trees = new_col[0..row].to_vec();
    trees.reverse();
    let top_score = tree_distance(trees, value);
    top_score * bottom_score * left_score * right_score
}
fn main() {
    // read file
    let matrix = include_str!("../../../inputs/input_8.txt")
        .lines()
        .map(|item| {
            item.chars()
                .map(|val| val.to_string().parse().unwrap())
                .collect::<Vec<usize>>()
        })
        .collect::<Vec<Vec<usize>>>();

    let row_length = matrix[0].len();
    let col_length = matrix.len();
    let mut res = 2 * row_length + 2 * col_length - 4;
    let mut max = 0;

    // for each tree in the forest
    for row in 1..(col_length - 1) {
        for col in 1..(row_length - 1) {
            if is_visible(&matrix, row, col) {
                res += 1;
            }
            let tmp = score(&matrix, row, col);
            if tmp > max {
                max = tmp;
            }
        }
    }

    println!("{}", res.to_string());
    println!("{}", max.to_string());
}
