#takes in a df in long format and the column number of the column containing factors
#returns a vector with the average of each level
avgLongFormat <- function(df, n){
        l <- levels(df$complexity)
        count <- 1
        avg <- numeric()
        for (i in l){
                temp <- df[df$complexity == i, 1]
                avg[count] <-  mean(temp)
                count <- count + 1
        }

        ##temporary solution
        a <- avg[1]
        c <- avg[3]
        avg[1] <- c
        avg[3] <- a

        avg
}
