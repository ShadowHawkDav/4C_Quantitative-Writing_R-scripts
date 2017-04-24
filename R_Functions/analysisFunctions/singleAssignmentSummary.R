##takes in a summary matrix for a single 4C assignment (produced by fourC.summary.R)
##and produces a single row of summary statistics
singleAssignmentSummary <- function(df)
{
        ##creates empty data frame with appropiate labels to store asgn.summary vector
        asgn.summary <- data.frame("average overall score"=rep(NA, 1), "calculation avg"=rep(NA, 1), "context avg"=rep(NA, 1), "comparison avg"=rep(NA, 1), "clarity avg"=rep(NA, 1), stringsAsFactors=FALSE)
        
        ##average overall score = total points earned/total number of statements 
        avg_score <- sum(df[,2])/sum(df[,1])
        
        ##fraction of statements that receieved a point for calculation
        calculation_avg <- sum(df[,4])/sum(df[,1])
        
        ##fraction of statements that receieved a point for context
        context_avg <- sum(df[,5])/sum(df[,1])
        
        ##fraction of statements that receieved a point for comparison
        comparison_avg <- sum(df[,6])/sum(df[,1])
        
        ##fraction of statements that receieved a point for clarity
        clarity_avg <- sum(df[,7])/sum(df[,1])
        
        asgn.summary <- c(avg_score, calculation_avg, context_avg, comparison_avg, clarity_avg)
}