average_score <- function(m, s){
        ## takes in a matrix m and a vector of scores s
        ## returns the average score per statement
        nr <- nrow(m)
        total_score <- 0
        for(i in 1:length(s)){
                total_score <- total_score + s[i]
        }
        avg_score <- total_score/nr
}

column_average <- function(m){
        ## takes in a matrix m and returns a vector containing the average of each C column (sum of each column/# statements)
        ## indicates what fraction of statements received credit for any given C
        nc <- ncol(m)
        nr <- nrow(m)
        avg_c <- numeric()
        for(i in 1:nc){
                sum <- 0
                for(j in 1:nr){
                        sum <- sum + m[j, i]
                }
                avg_c[i] <- sum/nr
        }
        avg_c
}

mode_vector <- function(s){
        ## takes in a vector s and returns ms, the mode of that vector
        ## returns NA if no unique mode exists
        ## indicates most common score per statement
        us <- unique(s)
        ms <- us[which.max(tabulate(match(s, us)))]
        if(length(us) == length(s)){
                ms <- NA
        }
        ms
}

number_of_statements <- function(m){
        ## number of statements (rows) in matrix m
        ns <- nrow(m)
}

range_vector <- function(s){
        ## takes in a vector s and returns rs, the range of that vector
        ## indicates the spread between the student's highest and lowest score
        r <- range(s)
        rs <- r[2] - r[1]
}

sum_statements <- function(m){
##finds the sums of the 4C scores for all statements in a matrix
        nr <- nrow(m)
        nc <- ncol(m)
        s <- numeric()
        for(i in 1:nr){
                sum <- 0
                for(j in 1:nc){
                        sum <- sum + m[i, j]
                }
                s[i] <- sum
        }
        s
}
