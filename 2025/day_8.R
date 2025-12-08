tab <- read.csv("day_8.txt", sep=",", header=FALSE)

# compute the euclidean distance for each point O(n^2)
d_mat <- as.matrix(dist(tab, method = "euclidean"))

# Set diagonal to Inf 
diag(d_mat) <- Inf

npoints <-  nrow(d_mat)

# set the list of clusters
clusters <- list()

# map each point with its cluster 
clusters_index <- rep(0, npoints) 
connection_count <- 0

# To limit computation, those values are not true all the time but just at the end
largest_cluster_index <- 1
largest_cluster_value <- 0

# For the first part
stop_at_n_link <- 1000 

while(TRUE) {
  
  # get the two closest point
  min_idx <- which(d_mat == min(d_mat), arr.ind = TRUE)[1, ] 
  p1 <- min_idx[1]
  p2 <- min_idx[2]
  
  # get their cluster index
  c1 <- clusters_index[p1]
  c2 <- clusters_index[p2]
  
  # update the matrix so it will no be min next time
  d_mat[p1, p2] <- Inf
  d_mat[p2, p1] <- Inf
  
  
  if (c1 == 0 & c2 == 0) {
    # New cluster
    new_id <- length(clusters) + 1
    clusters[[new_id]] <- c(p1, p2)
    clusters_index[p1] <- new_id
    clusters_index[p2] <- new_id
    
  } else if (c1 != 0 & c2 == 0) {
    # p1 is in cluster, p2 is new: Add p2 to c1
    clusters[[c1]] <- c(clusters[[c1]], p2)
    clusters_index[p2] <- c1
    
  } else if (c1 == 0 & c2 != 0) {
    # p2 is in cluster, p1 is new: Add p1 to c2
    clusters[[c2]] <- c(clusters[[c2]], p1)
    clusters_index[p1] <- c2
    
  } else if (c1 != c2) {
    # Merge two different clusters c2 into c1
    clusters[[c1]] <- c(clusters[[c1]], clusters[[c2]])
    
    # Update index map
    clusters_index[clusters[[c2]]] <- c1
    
    # Empty c2
    clusters[[c2]] <- integer(0)
    
    # update the largest cluster index and value if needed
    current_length <- length(clusters[[c1]])
    if (largest_cluster_value < current_length) {
      largest_cluster_value <- length(clusters[[c1]])
      largest_cluster_index <- c1
    }
    
  }
  # add connection
  connection_count <- connection_count + 1
  if (connection_count == stop_at_n_link - 1){
    # Remove empty clusters resulting from merges
    clean_clusters <- clusters[lengths(clusters) > 0]
    clusters_length <- sapply(clean_clusters, length)
    
    # Get top 3 sizes
    top_3 <- head(sort(clusters_length, decreasing = TRUE), 3)
    print(sprintf("cluster_1: %d, cluster_2: %d, cluster_3: %d",top_3[1],top_3[2],top_3[3]))
    print(sprintf("res_1: %d",prod(top_3))) 
  }
  
  # when the largest cluster is the same size of the number of points
  if (largest_cluster_value == npoints) {
    print(sprintf("x1: %d, x2: %d",tab$V1[p1], tab$V1[p2]))
    print(sprintf("res_2: %d",tab$V1[p1]*tab$V1[p2]))
    break
  }
}

