singleMatrixSummary <- function(m){
  sourceAll("./R_Functions/analysis/matrixSummary")
  
  ## number of rows
  #nr <- nrow(m)
  
  ## number of columns
  #nc <- ncol(m)
  
  ## vector s contains the sum of each row
  #s <- sum_row(m)
  
  ## total_score is the total number of points accumlated from all statements (sum of all rows)
  #total_score <- sum(s)
  
  ## avg_score is the student's average score per statement (sum of all rows/# rows)
  #avg_score <- average_score(m, s)
  
  ## col_score vector contains the sum of each column 
  ## indicates how many statements received credit for any given "C"
  #col_score <- column_score(m)
  
  ## s_var is the variance of the vector (s) that contains the sum of each row 
  ## indicates how the data values are dispersed around the mean (avg_score)
  #s_var <- var(s)
  
  ## ms is the mode of the sum vector
  ## indicates most common score per student 
  #ms <- mode_vector(s)
  
  ## rs is the range of the sum vector
  ## indicates the spread between the student's highest and lowest score
  #rs <- range_vector(s)
  
  ## med is the median of the sum vector 
  #med <- median(s)
  
  #summary_list <<- list("number of rows"=nr, "total score from all rows"=total_score, "average score per statement"=avg_score, 
   #                     "calculation sum"=col_score[1], "context sum"=col_score[2],
    #                    "comparison score"=col_score[3], "clarity score"=col_score[4], "variance of statement scores"=s_var,
     #                   "mode of statement scores"=ms, "range of statement scores"=rs, "median of statement scores"=med)
  
  funcList<-file_path_sans_ext(list.files("./R_Functions/analysis/matrixSummary", ".R")) 
  rm(list=funcList)
rm(funcList)        
  

}
