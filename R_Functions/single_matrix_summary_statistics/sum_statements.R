sum_statements <- function(m){
        nr <- nrow(m)
        nc <- ncol(m)
        s <- numeric()
        for(i in 1:nr){
                sum <- 0
                for(j in 1:nc){
                        sum <- sum + m[i, j]
                }
                s[i] <- sum
        }
        s
}