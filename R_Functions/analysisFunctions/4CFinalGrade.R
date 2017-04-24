##4CFinalExam takes in a filename, worksheet (of 4C scores and final exam scores) and working directory 
##utilizes dplyr package and ggplot2
fourCFinalGrade <- function(filename, wksheet, directory){
        wb <- loadWorkbook(paste(directory,"/",filename,sep=""))  
        sheet <- readWorksheet(wb, wksheet)
        ##sheet$score <- sprintf("%04d", sheet$score)
        sheet <- sheet[order(sheet$IDcode),]
        
        j <- 0
        for(i in sheet[,4]){
                j <- j + 1
                temp <- as.numeric(unlist(strsplit(as.character(i),"")))
                sheet[j, 4] <- temp[1]
                sheet[j, 5] <- temp[2]
                sheet[j, 6] <- temp[3]
                sheet[j, 7] <- temp[4]
        }
        sheet[, 4] <- sapply(sheet[, 4], as.numeric)
        colnames(sheet) <- c("IDcode", "finalscore", "statementnum", "calc", "context", "comp", "clarity")
        
        ##removes rows with incomplete data
        sheet <- na.omit(sheet)
        
        ##adds a new column that denotes which quartile the students fall into based on final exam scores
        quartile <- as.integer(cut(sheet$finalscore, quantile(sheet$finalscore, probs=c(0, 0.25, 0.5, 0.75, 1)), include.lowest = TRUE))
        sheet$quartile <- quartile
        
        ##creates 4 subsets of sheet filtered by quartile 
        q1 <- filter(sheet, quartile == 1)
        q2 <- filter(sheet, quartile == 2)
        q3 <- filter(sheet, quartile == 3)
        q4 <- filter(sheet, quartile == 4)
        
        ##calculates the percent of statements by students in q1 that included a calculation, context, comparison, clarity
        q1_calc <- sum(q1$calc)/nrow(q1)
        q1_context <- sum(q1$context)/nrow(q1)
        q1_comp <- sum(q1$comp)/nrow(q1)
        q1_clarity <- sum(q1$clarity)/nrow(q1)
        
        ##calculates the percent of statements by students in q2 that included a calculation, context, comparison, clarity
        q2_calc <- sum(q2$calc)/nrow(q2)
        q2_context <- sum(q2$context)/nrow(q2)
        q2_comp <- sum(q2$comp)/nrow(q2)
        q2_clarity <- sum(q2$clarity)/nrow(q2)
        
        ##calculates the percent of statements by students in q3 that included a calculation, context, comparison, clarity
        q3_calc <- sum(q3$calc)/nrow(q3)
        q3_context <- sum(q3$context)/nrow(q3)
        q3_comp <- sum(q3$comp)/nrow(q3)
        q3_clarity <- sum(q3$clarity)/nrow(q3)
        
        ##calculates the percent of statements by students in q4 that included a calculation, context, comparison, clarity
        q4_calc <- sum(q4$calc)/nrow(q4)
        q4_context <- sum(q4$context)/nrow(q4)
        q4_comp <- sum(q4$comp)/nrow(q4)
        q4_clarity <- sum(q4$clarity)/nrow(q4)
        
        q <- c("Q1", "Q2", "Q3", "Q4", "Q1", "Q2", "Q3", "Q4", "Q1", "Q2", "Q3", "Q4", "Q1", "Q2", "Q3", "Q4")
        condition <- c("calculation", "calculation", "calculation", "calculation", "context", "context", "context", "context", "comparison", "comparison", "comparison", "comparison", "clarity", "clarity", "clarity", "clarity")
        scores <- c(q1_calc, q2_calc, q3_calc, q4_calc, q1_context, q2_context, q3_context, q4_context, q1_comp, q2_comp, q3_comp, q4_comp, q1_clarity, q2_clarity, q3_clarity, q4_clarity)
        data <- data.frame(q, condition, scores)
        
        ##opens pdf in which graphs will be saved
        pdf(paste("finalScore_", wksheet, ".pdf", sep=""))
        
        g <- ggplot(data, aes(fill=condition, y=scores, x=q)) + geom_bar(position="dodge", stat="identity") + xlab("Quartile") + ylab("Percent of Statements") + ggtitle("W16 4C Pre-Test by Final Grades")
        
        plot(g)
        dev.off()
}