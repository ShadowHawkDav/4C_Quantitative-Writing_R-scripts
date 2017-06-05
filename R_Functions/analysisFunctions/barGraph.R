#df contains one column of a continuous variable and one column of a factor
#stdError is a vector containing the standard error of 4C scores for each factor (statement)
barGraph <- function(avgLongFormat, stdError){
        library(ggplot2)
        #df[,3] <- c(rep(stdError[1], 140), rep(stdError[2], 140), rep(stdError[3], 140))
        #colnames(df)[3] <- "std_err"

        f <- c("two", "three", "six")
        f <- as.factor(f)
        df <- data.frame(avgLongFormat, stdError, f)



        ggplot(df, aes(x=f, y=avgLongFormat, fill=f)) +
        stat_summary(geom="bar", color = "black", size = 1.0) +
        ylim(0, 4) +
        scale_fill_manual(values = c("#666666", "#56B4E9", "#096c74")) +
        xlab("Complexity") +
        ylab("Average 4C Score") +
        ggtitle("Effect of Complexity on Average 4C Score - PreTest W17") +
        scale_x_discrete(limits = c("two", "three", "six")) +
        geom_errorbar(aes(ymin = avgLongFormat - stdError, ymax = avgLongFormat + stdError), color = "black", width = .3)

}
