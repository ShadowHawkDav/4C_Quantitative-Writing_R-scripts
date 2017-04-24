## takes in a vector s and returns ms, the mode of that vector
## returns NA if no unique mode exists 
## indicates most common score per statement 
mode_vector <- function(s)
{
        us <- unique(s)
        ms <- us[which.max(tabulate(match(s, us)))]
        if(length(us) == length(s)){
                ms <- NA
        }
        ms
}