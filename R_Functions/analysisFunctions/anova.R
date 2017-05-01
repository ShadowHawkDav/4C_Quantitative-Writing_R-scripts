#df contains one column of a continuous variable and one column of a factor 
anova <- function(df){
        aov(scores ~ statement, data = df)
}