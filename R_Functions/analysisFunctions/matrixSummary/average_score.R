## takes in a matrix m and a vector of scores s
## returns the average score per statement
average_score <- function(m, s)
{
        nr <- nrow(m)
        total_score <- 0
        for(i in 1:length(s)){
                total_score <- total_score + s[i]        
        }
        avg_score <- total_score/nr
}