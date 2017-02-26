##col1, col2 must be numerics corresponding to the column numbers of the 2 columns to be compared
##lab1 and lab2 must be strings
##directory needed to save RDS to local file
direct_comparison <- function(col1, col2, df = CCCCdf, lab1 = a, lab2 = b, directory = "./4C_Writing-Analysis-in-R"){
        
        ##row names of comparison chart default to column names of df if custom names are omitted
        a <- colnames(df)[col1]
        b <- colnames(df)[col2]

        ##var1 and var2 contain data from the columns corresponding to col1 and col2
        var1 <- df[,col1]
        var2 <- df[,col2]
        
        ##computation of various statistics to be included as columns of the comparison chart
        mean1 <- mean(var1, na.rm = TRUE)
        mean2 <- mean(var2, na.rm = TRUE)
        
        min1 <- min(var1, na.rm = TRUE)
        min2 <- min(var2, na.rm = TRUE)
        
        max1 <- max(var1, na.rm = TRUE)
        max2 <- max(var2, na.rm = TRUE)
        
        range1 <- max1 - min1
        range2 <- max2 - min2
        
        sd1 <- sd(var1, na.rm = TRUE)
        sd2 <- sd(var2, na.rm = TRUE)
        
        vari1 <- var(var1, na.rm = TRUE)
        vari2 <- var(var2, na.rm = TRUE)
        
        coef.var1 <- (sd1/mean1) * 100
        coef.var2 <- (sd2/mean2) * 100
        
        row1 <- c(mean1, min1, max1, range1, sd1, vari1, coef.var1)
        row2 <- c(mean2, min2, max2, range2, sd2, vari2, coef.var2)
        
        
        compare_sum <<- rbind(row1, row1)
        compare_sum <<- as.data.frame(compare_sum, row.names = c(lab1, lab2))
        colnames(compare_sum) <<- c("Mean", "Minimum", "Maximum", "Range", "Std Dev", "Variance", "Coefficient of Variation")
        
        ##saveRDS(compare_sum, paste(directory,"/Analyses and Outputs","/","compare_sum_",month(Sys.Date()),"_",day(Sys.Date()),".RData",sep=""))
}