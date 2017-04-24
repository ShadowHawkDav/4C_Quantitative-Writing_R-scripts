## function takes in a single column of the CCCCdf representing 4C scores and returns a 
## data frame in which each student represents a row and each column represents a (labeled) 
## summary statistic from the fcn call single_matrix_summary.R
fourCSummary <- function(b)
{
        ## remove NA values from given columns
        b <- na.omit.list(b)
        
        ## creates an empty frame in which each student represents a row and each column represents a 
        ## summary statistic from the fcn call single_matrix_summary.R
        n <- length(b)
        df <- data.frame("number of rows"=rep(NA, n), "total score from all rows"=rep(NA, n), "average score per statement"=rep(NA, n), 
                         "calculation sum"=rep(NA, n), "context sum"=rep(NA, n), "comparison sum"=rep(NA, n), "clarity sum"=rep(NA, n), 
                         "variance of statement scores"=rep(NA, n), "mode of statement sores"=rep(NA, n), "range of statement scores"=rep(NA, n), 
                         "median of statement scores"=rep(NA, n), stringsAsFactors=FALSE)
        
        
        ## fills each cell the empty data frame with the approiate summary statistic, returned 
        ## as a list by single_matrix_summary.R
        for(i in 1:length(b)){
                temp <- matrix(unlist(b[i]), nrow = length(b[i]), byrow = TRUE)
                df[i, ] <- single_matrix_summary(temp)
        }
        df
}