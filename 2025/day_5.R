lines <- strsplit(readLines("day_5.txt"),"-")
ranges <- list();
index <- 1;
res_1 <- 0;
res_2 <- 0;

mergeOverlap <- function(arr) {
  # Sort intervals based on start values
  arr <- arr[order(sapply(arr, "[[", 1))]
  
  res <- list(arr[[1]])
  
  for (i in 2:length(arr)) {
    last <- res[[length(res)]]
    curr <- arr[[i]]
    
    # If current interval overlaps with the last merged interval
    if (curr[1] <= last[2]) {
      # Merge intervals
      res[[length(res)]][2] <- max(last[2], curr[2])
    } else {
      # Append new interval
      res <- append(res, list(curr))
    }
  }
  
  return(res)
}

for (line in lines){
  n <- length(line)
  if (n == 2){
    # get all the ranges
    L <-as.numeric(line[1])
    R <-as.numeric(line[2])
    ranges[[index]] <- c(L,R);
    index <- index + 1;
  } else if (n == 1) {
    # check if the number is in the ranges
    for (range in ranges){
      digit <- as.numeric(line[1])
      if (digit >= range[1] && digit <= range[2]){
        res_1 <- res_1 + 1;
        break
      }
    }
  }
}

merge_ranges <- mergeOverlap(ranges)
for (range in merge_ranges){
  res_2 <- res_2 + (range[2]-range[1]) + 1
}

print(res_1);
print(res_2);
