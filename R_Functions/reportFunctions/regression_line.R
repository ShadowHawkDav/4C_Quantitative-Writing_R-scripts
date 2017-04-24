##takes an existing scatter plot as an argument and adds a regression line
regression_line <- function(plot) {
        plot <- plot + geom_smooth(method = "lm", color = "blue") 
        plot
}