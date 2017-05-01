#df contains one column of a continuous variable and one column of a factor 
boxPlot <- function(df){
        df$statement = factor(df$statement,c("one","two","three"))
        plot(scores ~ statement, data = df)
}