mat <-do.call(rbind,strsplit(readLines("day_1.txt"),"\\s+"));
mat <-  matrix(as.numeric(mat),
               nrow = nrow(mat),
               ncol = ncol(mat))
# order left and right list 
order_list_left <-mat[,1][order(mat[,1])]
order_list_right <-mat[,2][order(mat[,2])]

# get the distance between the two list and sum everything
res_1 <- sum(abs(order_list_left - order_list_right))


res_2 <- 0
# for each element in the order left list
for (i in 1:length(order_list_left)){
  # count the number of element in the right list that are equals to the element
  n<-length(order_list_right[order_list_right == order_list_left[i]])
  # compute the result
  res_2 <- res_2 + order_list_left[i] * n;
}

print(res_1)
print(res_2)
