#df contains one column of a continuous variable and one column of a factor
boxPlot <- function(df){
        df$complexity = factor(df$complexity,c("two","three","six"))
        plot(scores ~ complexity, data = df)
}
