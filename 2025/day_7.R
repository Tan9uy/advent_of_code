f <- file("day_7.txt","rt")

# Convert directly to a matrix of characters
mat <- do.call(rbind, strsplit(readLines(f),split=""))
ncols <- ncol(mat)
nrows <- nrow(mat)
index <- 0

# store the position of each beams and the number of timelines
index_list <- rep(0, ncols)
# add the first timeline
index_list[which(mat[1,] == "S")] <- 1
split_count <- 0
for (i in 2:nrows){
  for (j in 1:ncols){
    # when the beam split
    if (mat[i,j] == "^" & index_list[j] >= 1){
      # increment the split count
      split_count <- split_count + 1;
      
      # Split into two beams and keep the number of timelines in each index
      # left beam
      index_list[j-1] <- index_list[j-1] + index_list[j];
      mat[i,j-1] <- "|";
      # right beam
      index_list[j+1] <-  index_list[j+1] + index_list[j];
      mat[i,j+1] <- "|";
      index_list[j] <- 0;
    } else if (index_list[j] >= 1) {
      # continue the beam
      mat[i,j] <- "|";
    }
  }
}

options(scipen=999)
# part 1
print(split_count)
# part 2
print(sum(index_list))