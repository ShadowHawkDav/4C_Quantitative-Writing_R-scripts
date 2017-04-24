## takes in a vector s and returns rs, the range of that vector 
## indicates the spread between the student's highest and lowest score
range_vector <- function(s)
{
        r <- range(s)
        rs <- r[2] - r[1]
}