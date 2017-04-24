##col1 and col2 must be numerics corresponding to the column numbers of the 2 columns to be compared
##xlab and ylab arguments must be strings 
##rows with NA values automatically removed 
direct_comparison <- function(col1, col2, df = CCCCdf, xlab = a, ylab = b){
        a <- colnames(df)[col1]
        b <- colnames(df)[col2]
        
        x <- df[,col1]
        y <- df[,col2]
        
        ##opens pdf in which plot will be saved 
        pdf(file = paste("./Analyses and Outputs/",xlab,"_",ylab,Sys.Date(),".pdf"))
        
        ##scatterplot
        scatter <<- scatterplot(x, y, df, xlab, ylab)
        
        ##regression line
        ##gray space represents 95% confidence interval 
        scatter <<- regression_line(scatter)
        
        ##save graph to "Analyses and Outputs" folder
        ##plot(scatter)
        ##dev.off()
        
        rmarkdown::render("direct_comparison.R", "pdf_document")
        
        ##returns scatter plot
        scatter
        
}
