input <- read.delim("day_2.txt", header = FALSE)

# get the ranges from the line
ranges <- unlist(strsplit(input$V1,","));

# split the range to get both IDs
tab_ranges <- strsplit(ranges,"-");

# PART I

res_1 <- 0
# for each ranges
for (range in tab_ranges) {
  # convert the IDs in number
  start <- as.numeric(range[1]);
  end <- as.numeric(range[2]);

  # For each number in the range between ID start and Id end
  for (i in start:end){
    # transform the number into a character
    id <- as.character(i);
    # get both part of the ID to see if they are the same
    id_start <- substring(id,1,nchar(id)%/%2);
    id_end <- substring(id,nchar(id)%/%2 +1,nchar(id));
    if (id_start==id_end){
      # increment the counter
      res_1 <- res_1 + i;
    }
  }
}

# PART II

res_2 <- 0
split_id <- function(id, parts) {
  id_size <-nchar(id);
  
  # break the recursion
  if (parts <= 1){
    return(-1);
  }
  
  # If it cannot be split by parts count
  if (id_size %% parts != 0){
    return(split_id(id, parts-1));
  }
  
  # split by parts count
  part_size <- id_size%/%parts;
  first_part <- substring(id,1,part_size);
  
  # for each part
  for (i in seq(part_size,id_size-part_size,part_size)){
    next_part <-substring(id,i+1,i+part_size);
    # compare each part with the first part
    if (next_part != first_part){
      # continue the recursion if the one part is different
      return(split_id(id, parts-1));
    } 
  }
  # If it reach here then all the parts are equals.
  return(first_part)
}


# for each ranges
for (range in tab_ranges) {
  # convert the IDs in number
  start <- as.numeric(range[1]);
  end <- as.numeric(range[2]);
  
  # For each number in the range between ID start and Id end
  for (i in start:end){
    # transform the number into a character
    id <- as.character(i);
    # get the repeated value or -1 if nothing is found.
    value <- split_id(id,nchar(id));
    
    # increment counter if a value is found.
    if (value != -1){
      res_2 <- res_2 + i;
    }
  }
}

print(res_1)
print(res_2)