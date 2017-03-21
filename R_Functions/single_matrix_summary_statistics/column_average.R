## takes in a matrix m and returns a vector containing the average of each C column (sum of each column/# statements)
## indicates what fraction of statements received credit for any given C
column_average <- function(m)
{
        nc <- ncol(m)
        nr <- nrow(m)
        avg_c <- numeric()
        for(i in 1:nc){
                sum <- 0
                for(j in 1:nr){
                        sum <- sum + m[j, i]
                }
                avg_c[i] <- sum/nr
        }
        avg_c
}