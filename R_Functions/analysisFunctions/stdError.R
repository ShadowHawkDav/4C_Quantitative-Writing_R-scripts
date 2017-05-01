#df contains one column of a continuous variable and one column of a factor
stdError <- function(df){
        d1 <- filter(df, statement == "one")
        var1 <- var(d1$scores)
        se1 <- sqrt(var1/nrow(d1))
        
        d2 <- filter(df, statement == "two")
        var2 <- var(d2$scores)
        se2 <- sqrt(var2/nrow(d2))
        
        d3 <- filter(df, statement == "three")
        var3 <- var(d3$scores)
        se3 <- sqrt(var3/nrow(d3))
        
        stdError <- c(se1, se2, se3)
}