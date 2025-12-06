f <- file("day_6.txt","rt")

# PART I
# Convert directly to a matrix of characters
lines <- strsplit(readLines(f),split='\\s+')

# remove empty element in the list
for (i in 1:length(lines)){
  lines[[i]]<-lines[[i]][lines[[i]]!=""]
}
# create a matrix of characters
char_matrix <- do.call(rbind,lines)

# get only the matrix with numbers
n_rows <- nrow(char_matrix)
numbers_matrix <- matrix(as.numeric(char_matrix[1:(n_rows-1),]),
                                              nrow = n_rows-1,
                                              ncol = ncol(char_matrix))
# get only the operation vectors
operations_vect <- char_matrix[n_rows:n_rows,]

# For every col compute the operation based on the last element
res_1 <- 0
for (col in 1:ncol(numbers_matrix)){
  if (operations_vect[col] == "*"){
    res_1 <- res_1 + prod(numbers_matrix[,col])
  }
  if (operations_vect[col] == "+"){
    res_1 <- res_1 + sum(numbers_matrix[,col])
  }
}

# PART II
res_2 <- 0
# parse the file in a matrix for each character
mat <-  do.call(rbind,strsplit(readLines("day_6.txt"),""))
numbers_count <- nrow(mat)-1

# get the first operation
op <- mat[numbers_count+1,1]
ncols = ncol(mat)  
# set the first value 1 if "*" or 0 if "+"
current_op_res <- as.numeric(op == "*")

# for each col of the matrix
for (col in 1:ncols){
  # get the number that are formed in the column
  number <- as.numeric(paste(mat[1:numbers_count,col], collapse = ''))
  
  # if no number is found that means that we between two "main" column
  if (is.na(number)) {
    # update the main answear
    res_2 <- res_2 + current_op_res
    # get the next operation
    op <- mat[numbers_count+1,col+1]
    # set the next operation value
    if (op == "+") {
      current_op_res <- 0
    }
    if (op == "*") {
      current_op_res <- 1
    }
    next
  }
  # compute the operation based on the op and the number
  if (op == "+") current_op_res <- current_op_res + number
  if (op == "*") current_op_res <- current_op_res * number
  
  # for the last col add the last result to the main result
  if (col == ncols){
    res_2 <- res_2 + current_op_res
  }
}

options(scipen=999)

print(res_1)
print(res_2)