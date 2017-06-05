lineGraph <- function(avgLongFormat, stdError){
        library(ggplot2)

        f <- c("two", "three", "six")
        f <- as.factor(f)
        complexity <- c(2, 3, 6)
        df <- data.frame(avgLongFormat, stdError, f, complexity)

        ggplot(df, aes(x=complexity, y=avgLongFormat, group=1)) +
                geom_point(position = position_dodge(width = 1.0)) +
                ylim(0, 4) +
                xlim(0, 7) +
                scale_fill_manual(values = c("#666666", "#56B4E9", "#096c74")) +
                xlab("Complexity") +
                ylab("Average 4C Score") +
                ggtitle("Effect of Complexity on Average 4C Score in the 1st Quartile of Final Exam (Genetic) Scores - PreTest W17") +
                #scale_x_discrete(limits = c("two", "three", "six")) +
                geom_errorbar(aes(ymin = avgLongFormat - stdError, ymax = avgLongFormat + stdError), color = "black", width = .1) +
                geom_line(size=0.7)

}
