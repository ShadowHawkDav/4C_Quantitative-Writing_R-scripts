#df is the dataframe in which the 4C matrices are stored
averageByComplexity <- function(df) {
        sourceAll("./R_Functions/analysisFunctions/matrixSummary")
        n <- nrow(df)
        avgFrame <- data.frame(IDcode=df[,1], statementOne_score=numeric(n), statementTwo_score=numeric(n), statementThree_score=numeric(n))
        for(i in 1:n){
                s <- sum_statements(df[[i,2]])
                avgFrame[i,2] <- s[1]
                avgFrame[i,3] <- s[2]
                avgFrame[i,4] <- s[3]
        }
        
        allScoresByComplexity <- data.frame(scores=numeric(3*n), statement=character(3*n))
        for(i in 1:n){
             allScoresByComplexity[i,1] <- avgFrame[i,2] 
             allScoresByComplexity[i,2] <- "one"
        }
        j <- 1
        for(i in (n+1):(2*n)){
                allScoresByComplexity[i, 1] <- avgFrame[j, 3]
                allScoresByComplexity[i, 2] <- "two"
                j <- j+1
        }
        j <- 1
        for(i in ((2*n)+1):(3*n)){
                allScoresByComplexity[i,1] <- avgFrame[j,4]
                allScoresByComplexity[i,2] <- "three"
                j <- j+1
        }
        allScoresByComplexity[,2] <- as.factor(allScoresByComplexity[,2]) 
        
        assign("allScoresByComplexity", allScoresByComplexity, envir = .GlobalEnv)
        assign("avgFrame", avgFrame, envir = .GlobalEnv)
        
}
