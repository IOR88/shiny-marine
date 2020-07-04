library(geosphere)

getLongestObservation <- function(observations){
  # Gets a list of objects with LAT and LON, each
  # consecutive pair Oi + Oi+1 has to be measured in terms
  # what distance was achieved. The pair with the longest
  # distance will be returned.
  distance = 0
  ob1 = NULL
  ob2 = NULL
  if(length(observations) > 1){
    for (x in 1:nrow(observations)){
      temp_ob1 = observations[x,]
      temp_ob2 = observations[x+1,]
      
  
      temp_distance = distm (
        c(temp_ob1[,"LON"], temp_ob1[,"LAT"]), c(temp_ob2[,"LON"], temp_ob2[,"LAT"]), 
        fun = distHaversine
      )
  
      if(!is.na(temp_distance[,]) && temp_distance[,] > distance){
         distance <- temp_distance[,]
         ob1 <- temp_ob1
         ob2 <- temp_ob2
      }
    }
  }
  robservations <- rbind(ob1, ob2)
  # using structure instead of vector is easier to reason about as vector structure 
  # was merging data frame with double and extracting logical sense from function
  # output was more difficult
  structure(list(), distance=distance, observations=robservations)
}
