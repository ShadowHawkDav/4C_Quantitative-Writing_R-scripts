#df contains one column of a continuous variable and one column of a factor 
complexityAnalysis <- function(df){
        source("./R_Functions/analysisFunctions/boxPlot.R")
        source("./R_Functions/analysisFunctions/anova.R")
        source("./R_Functions/analysisFunctions/tukeyTest.R")
        source("./R_Functions/analysisFunctions/stdError.R")
        source("./R_Functions/analysisFunctions/barGraph.R")
        
        #graphically compare 4C scores from statements of varying complexity 
        boxPlot(df)
        
        #is there significant differences in the K population means? 
        #Pr (>F) denotes p-value for H0: all groups have equal means 
        anova_results <- anova(df)
        summary(anova_results)
        
        #if yes, what is driving the difference in means? 
        #pairwise comparisons between all groups
        tukeyTest(df, anova_results)
        
        #returns the standard error of scores by statement number 
        #(standard deviation/square root of sample size)
        stdError <- stdError(df)
        
        ##creates a bar graph comparing complexity to average 4C scores 
        barGraph(df, stdError)
}