input <- read.delim("day_1.txt", header = FALSE)
start <- 50; # input position

# set counters values
zero_count <- 0;
zero_count_2 <- 0;

# For each movement (L20 or R20)
for (line in input$V1) {
  # get The first letter "L" or "R" for the dial direction
  direction <- as.character(substring(line,1,1));
  
  # get the number of clicks
  number <- as.numeric(substring(line,2,nchar(line)));
  
  
  if (direction == 'L'){
    # When moving left the number becomes negative
    diff <- start - number; 
    # get the number of turns without the first transition.
    zero_count_2 <- zero_count_2 + abs(diff)%/%100;
    # Add 1 for the transition from + to -
    if (diff <= 0 && start > 0 ){
      zero_count_2 <- zero_count_2 + 1;
    }
    # Reset the dial between 0 and 99
    start <- (diff) %% 100;
  } else {
    # if the direction is right the number stays positive
    diff <- start + number;
    # Reset the dial between 0 and 99
    start <- diff %% 100;
    # count the number of positive turns.
    zero_count_2 <- zero_count_2 +diff%/%100;
  }
  # when the dial ends on 0 increment.
  if (start == 0){
    zero_count <- zero_count + 1;
  }
}

print(zero_count)
print(zero_count_2)