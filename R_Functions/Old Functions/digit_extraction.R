digit_extraction <- function(conversion, frame){
        j <- 0
        for (i in frame[,2]){
                j <- j + 1
                num <- i
                temp <- as.numeric(unlist(strsplit(as.character(num),""))) ##breaks 6 digit number to be parsed
                conversion[j, 2] <- temp[1] ##assigns first digit of number to second column of data frame, etc 
                                                ## (first column will be ID number)
                conversion[j, 3] <- temp[2]
                conversion[j, 4] <- temp[3]
                conversion[j, 5] <- temp[4]
                conversion[j, 6] <- temp[5]
                conversion[j, 7] <- temp[6]
        }
        colnames(conversion) <- c("IDcode", "statementnum", "comp", "calc", "context", "clarity", "score")
        return(conversion)
}