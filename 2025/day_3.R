library(tidyverse)

# to avoid scientific notation
options(scipen = 100, digits = 4)

 res_1 <- readLines("day_3.txt") %>%
  map(function(line) {
    # get the list of digits
    numbers_list <- strsplit(line, "") %>%
      unlist() %>%
      as.numeric();
    # get the index of maximum in the list but keep the last one out for the second digit
    # The last one cannot be used because we will not be able to take another digit.
    max_index <- numbers_list[1:length(numbers_list)-1] %>%
      which.max();
    # Get the second digit with the remaining list after the first digit.
    last_digit <- numbers_list[(max_index+1):length(numbers_list)] %>%
      max();
    # form the final number.
    return(numbers_list[max_index] * 10 + last_digit);
  }) %>% 
  unlist() %>% # flatten the the list 
  sum() # sum to get the result

res_2 <- readLines("day_3.txt") %>%
  map(function(line) {
    # get the list of digits
    numbers_list <- strsplit(line, "") %>%
      unlist() %>%
      as.numeric();
    # init the final number at 0
    number <- 0;
    # fist_index will be used to reduce the list from the left
    first_index <- 1;
    list_length <- length(numbers_list);
    for (i in 12:1) {
      # get the index of maximum in the list but keep the lasts i-1 digits for later
      # The i-1 index cannot be used because we will not be able to take them later.
      max_index <- numbers_list[first_index:(list_length-(i-1))] %>%
        which.max();
      # compute the number
      number <- number + numbers_list[max_index + first_index -1] * 10 ** (i-1);
      # reset the index to limit the search for the next digit
      first_index <-max_index + first_index;
    }
    return(number);
  }) %>% 
  unlist() %>%  # flatten the the list 
  sum() # sum to get the result

print(res_1)
print(res_2)