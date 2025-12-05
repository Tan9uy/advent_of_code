f <- file("day_4.txt","rt")
# Convert directly to a matrix of characters
char_matrix <- do.call(rbind, strsplit(readLines(f), ""))

get_neighbour_counts <- function(grid){
  H <- nrow(grid)
  W <- ncol(grid)
  
  # add padding on each side of the matrix
  padded <- matrix(0, nrow = H + 2, ncol = W + 2)
  padded[2:(H + 1), 2:(W + 1)] <- grid
  
  # compute the neighbours with a sliding matrix
  neighbours <- 
    padded[1:H,1:W] + # top left
    padded[2:(H+1),1:W] + # middle left 
    padded[3:(H+2),1:W] + # bottom left
    padded[1:H,2:(W+1)] + # middle top
    padded[1:H,3:(W+2)] + # top right
    padded[2:(H+1),3:(W+2)] + # middle right
    padded[3:(H+2),3:(W+2)] + # bottom right
    padded[3:(H+2),2:(W+1)] # Middle bottom

  return(neighbours);
}

# convert the matrix into 0 and 1 : 1 for "@" and 0 for "."
grid <- (char_matrix == "@") * 1
iter_counts <- 1
is_data <- TRUE
res_2 <- 0
while (is_data) {
  count <- get_neighbour_counts(grid)
  
  # filter the data to keep only the rolls with less than 4 neighbours 
  filter <- (grid == 1) & (count < 4)
  
  rolls_count <- sum(as.numeric(filter))
  
  # no rolls is left to remove, we can stop the loop
  is_data <- !(rolls_count == 0)
  
  if (iter_counts == 1){
    # sum the matrix using the filter
    res_1 <- rolls_count;
  }
   
  res_2 <- res_2 + rolls_count;
  iter_counts <- iter_counts + 1;
  
  # remove the rolls based on the filter
  grid[filter] <- 0;
}

print(res_1)
print(res_2)







