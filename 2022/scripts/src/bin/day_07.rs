use core::str::Lines;

#[derive(Clone, Debug)]
struct Folder {
    size: i32,
    folders: Vec<Folder>,
}

#[derive(Debug)]
struct File {
    size: i32,
}

fn parse_folder(lines: &mut Lines) -> Folder {
    let mut size = 0;
    let mut files: Vec<File> = Vec::new();
    let mut folders: Vec<Folder> = Vec::new();
    while let Some(line) = lines.next() {
        // read command
        match &line[0..4] {
            "$ cd" => {
                if line.len() == "$ cd ..".len() && ".." == &line[5..] {
                    break;
                } else {
                    folders.push(parse_folder(lines));
                }
            }
            "$ ls" => continue,
            _ => {
                let array: Vec<&str> = line.splitn(2, ' ').collect();
                match array[0] {
                    // if dir do nothing
                    "dir" => continue,
                    // Create a file
                    _ => {
                        files.push(File {
                            size: array[0].parse().unwrap(),
                        });
                    }
                };
            }
        }
    }
    // count the folders size
    size += folders
        .iter()
        .map(|sub_folder| sub_folder.size)
        .sum::<i32>();
    // count the files size
    size += files.iter().map(|file| file.size).sum::<i32>();

    Folder {
        folders: folders,
        size: size,
    }
}

fn parse(mut lines: Lines) -> Folder {
    // remove the root folder
    lines.next().unwrap();
    return parse_folder(&mut lines);
}

fn solution(folder: Folder) -> i64 {
    let mut sum: i64 = 0;
    if folder.size < 100000 {
        sum += folder.size as i64;
    }
    for f in folder.folders {
        sum += solution(f);
    }

    return sum;
}

fn solution_2(folder: Folder, limits: i64, mut best_folder: i64) -> i64 {
    let min: i64 = folder.size as i64;
    for f in folder.folders {
        let value = solution_2(f, limits, best_folder);
        if value >= limits && best_folder > value {
            best_folder = value;
        }
    }
    if min > limits && min < best_folder {
        best_folder = min;
    }
    return best_folder;
}
fn main() {
    // read file
    let lines = include_str!("../../../inputs/input_7.txt").lines();

    // parse the file
    let root_folder = parse(lines);

    // get the sum of each folder with the size < 100000
    println!("PART I : {}", solution(root_folder.clone()).to_string());
    let unused_space = (70000000 - root_folder.clone().size) as i64;

    // get the smallest folder to remove to have enough space for the update.
    println!(
        "PART II : {}",
        solution_2(
            root_folder.clone(),
            30000000 - unused_space,
            root_folder.clone().size as i64
        )
        .to_string()
    );
}
