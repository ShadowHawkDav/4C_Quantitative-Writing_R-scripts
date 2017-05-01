#df contains one column of a continuous variable and one column of a factor 
#results is a fitted model object (ie an aov fit)
tukeyTest <- function(df, results){
        TukeyHSD(results, conf.level = 0.95)        
}