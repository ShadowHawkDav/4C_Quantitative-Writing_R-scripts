##x and y variables must be columns of a data frame
scatterplot <- function(x, y, df = CCCCdf, xlab = a, ylab = b){
        scatter <- ggplot(df, aes(x, y))
        scatter <- scatter + geom_point() 
        ##scatter <- scatter + goem_point(color = "red")
        ##scatter <- scatter + geom_point(size = 1)
        scatter <- scatter + xlab(xlab) + ylab(ylab)
        scatter
} 