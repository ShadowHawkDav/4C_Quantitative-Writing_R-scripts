#df contains one column of a continuous variable and one column of a factor
#stdError is a vector containing the standard error of 4C scores for each factor (statement)
barGraph <- function(df, stdError){
        library(ggplot2)
        #df[,3] <- c(rep(stdError[1], 140), rep(stdError[2], 140), rep(stdError[3], 140))
        #colnames(df)[3] <- "std_err"

        ggplot(df, aes(x=statement, y=scores, fill=statement)) +
                stat_summary(fun.y = "mean", geom="bar", color = "black", size = 1.0) +
                ylim(0, 4) +
                scale_fill_manual(values = c("#666666", "#56B4E9", "#096c74")) +
                xlab("Statement") +
                ylab("Average 4C Score") +
                ggtitle("Effect of Complexity on Average 4C Score - PreTest W17") +
                scale_x_discrete(limits = c("one", "two", "three"))
        #+ geom_errorbar(aes(ymin = scores - std_err, ymax = scores + std_err))

}

#df contains one column of a continuous variable and one column of a factor
boxPlot <- function(df){
        df$statement = factor(df$statement,c("one","two","three"))
        plot(scores ~ statement, data = df)
}


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
