matrix.summary <- function(m)
{
        sourceAll("./R_Functions/single_matrix_summary_statistics")
        
        ## number of statements
        nr <- number_of_statements(m)
        
        ## number of columns
        nc <- ncol(m)
        
        ## vector s contains the sum of each statement
        s <- sum_statements(m)
        
        ## avg_score is average score per statement (sum of all statements/# statements)
        total_score <- 0
        for(i in 1:length(s)){
                total_score <- total_score + s[i]        
        }
        avg_score <- total_score/nr
        
        ## avg_c vector contains the average of each "C" column (sum of each column/# statements)
        ## indicates what fraction of statements received credit for any given "C"
        avg_c <- numeric()
        for(i in 1:nc){
                sum <- 0
                for(j in 1:nr){
                        sum <- sum + m[j, i]
                }
                avg_c[i] <- sum/nr
        }
        
        ## s_dev is the standard deviation of the sum vector
        ## indicates consistency 
        s_dev <- sd(s)
        
        ## ms is the mode of the sum vector
        ## indicates most common score per statement 
        us <- unique(s)
        ms <- us[which.max(tabulate(match(s, us)))]
        if(length(us) == length(s)){
                ms <- 0
        }
        
        ## rs is the range of the sum vector
        ## indicates the spread between the student's highest and lowest score
        r <- range(s)
        rs <- r[2] - r[1]
        
        summary_list <- list("number of statements"=nr, "sum of each statement"=s, "average score per statement"=avg_score, 
                             "average of each C column"=avg_c, "standard deviation of the sum vector"=s_dev,
                             "mode of the sum vector"=ms, "range of the sum vector"=rs)
        
        
}
