library(purrr)
lines <- map(strsplit(readLines("day_2.txt")," "), as.numeric)

res_1 <- 0
res_2 <- 0

# check if the list is safe
is_safe <- function(vec){
  # compute the diff to get the steps between the levels
  diff_list <- diff(vec,1);
  
  min_diff <- min(diff_list);
  max_diff <- max(diff_list);
  
  # check if the order is ok
  if (min_diff <= 0 & max_diff >= 0){
    return(FALSE)
  }
  
  # check if the levels is not two high 
  if (abs(max_diff) > 3 | abs(min_diff) > 3){
    return(FALSE)
  }
  
  return(TRUE)
}

for (i in 1:length(lines)){
  
  # check for part 1
  if (is_safe(lines[[i]])){
    res_1 <- res_1 + 1
  } 
    
  # check each lines with one number off
  for (j in 1:length(lines[[i]])){
    if (is_safe(lines[[i]][-j])){
      res_2 <- res_2 + 1
      break
    }
  }
}
print(res_1)
print(res_2)