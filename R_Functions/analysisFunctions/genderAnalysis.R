##genderAnalysis takes in a filename, worksheet (of 4C scores) and working directory 
genderAnalysis <- function(filename, wksheet, directory) {
        
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
        
        ##removes rows with incomplete data
        sheet <- na.omit(sheet)
        
        ##adds a "total" column to the df
        j <- 0
        for(i in sheet[,4]){
                j <- j + 1
                total <- sum(sheet[j,4] + sheet[j,5] + sheet[j,6] + sheet[j,7])
                sheet[j, 8] <- total
        }
        colnames(sheet) <- c("IDcode", "gender", "statementnum", "calc", "context", "comp", "clarity", "total")
        
        ##counts the number of statements by women (ns_women) and the number of statements by men (ns_men)
        gender <- sheet$gender
        gcount <- table(gender)
        ns_women <- unname(gcount[1])
        ns_men <- unname(gcount[2])
        
        ##sums the calc column by women (calcsum_f) and by men (calcsum_m)
        calc <- split(sheet$calc, gender)
        calcsum_f <- sum(calc$f)
        calcsum_m <- sum(calc$m)
        
        ##calculates the percent of statements by women (calc_f) and by men (calc_m) that incuded a calculation
        calc_f <- calcsum_f/ns_women
        calc_m <- calcsum_m/ns_men
        
        ##sums the context column by women (context_f) and by men (context_m)
        context <- split(sheet$context, gender)
        contextsum_f <- sum(context$f)
        contextsum_m <- sum(context$m)
        
        ##calculates the percent of statements by women (context_f) and by men (context_m) that incuded context
        context_f <- contextsum_f/ns_women
        context_m <- contextsum_m/ns_men
        
        ##sums the comparison column by women (compsum_f) and by men (compsum_m)
        comp <- split(sheet$comp, gender)
        compsum_f <- sum(comp$f)
        compsum_m <- sum(comp$m)
        
        ##calculates the percent of statements by women (comp_f) and by men (comp_m) that incuded a comparison 
        comp_f <- compsum_f/ns_women
        comp_m <- compsum_m/ns_men
        
        ##sums the clarity column by women (clarsum_f) and by men (clarsum_m)
        clarity <- split(sheet$clarity, gender)
        clarsum_f <- sum(clarity$f)
        clarsum_m <- sum(clarity$m)
        
        ##calculates the percent of statements by women (clar_f) and by men (clar_m) that were clear
        clar_f <- clarsum_f/ns_women
        clar_m <- clarsum_m/ns_men
        
        ##sums the total column by women (totalsum_f) and by men (totalsum_m)
        total <- split(sheet$total, gender)
        totalsum_f <- sum(total$f)
        totalsum_m <- sum(total$m)
        
        ##BY COMPLEXITY (statementnum)
        ##sums the percent of statements made by women (f) and men (m) that included a comparison by statementnum
        a <- split(sheet$comp, list(sheet$statementnum, sheet$gender))
        comp_f_1 <- sum(a$'1.f')/(length(a$'1.f'))
        comp_f_2 <- sum(a$'2.f')/(length(a$'2.f'))
        comp_f_3 <- sum(a$'3.f')/(length(a$'3.f'))
        comp_m_1 <- sum(a$'1.m')/(length(a$'1.m'))
        comp_m_2 <- sum(a$'2.m')/(length(a$'2.m'))
        comp_m_3 <- sum(a$'3.m')/(length(a$'3.m'))
        
        ##sums the percent of statements made by women (f) and men (m) that included context by statementnum
        b <- split(sheet$context, list(sheet$statementnum, sheet$gender))
        context_f_1 <- sum(b$'1.f')/(length(b$'1.f'))
        context_f_2 <- sum(b$'2.f')/(length(b$'2.f'))
        context_f_3 <- sum(b$'3.f')/(length(b$'3.f'))
        context_m_1 <- sum(b$'1.m')/(length(b$'1.m'))
        context_m_2 <- sum(b$'2.m')/(length(b$'2.m'))
        context_m_3 <- sum(b$'3.m')/(length(b$'3.m'))
        
        ##sums the percent of statements made by women (f) and men (m) that included a calculation by statementnum
        c <- split(sheet$calc, list(sheet$statementnum, sheet$gender))
        calc_f_1 <- sum(c$'1.f')/(length(c$'1.f'))
        calc_f_2 <- sum(c$'2.f')/(length(c$'2.f'))
        calc_f_3 <- sum(c$'3.f')/(length(c$'3.f'))
        calc_m_1 <- sum(c$'1.m')/(length(c$'1.m'))
        calc_m_2 <- sum(c$'2.m')/(length(c$'2.m'))
        calc_m_3 <- sum(c$'3.m')/(length(c$'3.m'))
        
        ##sums the percent of statements made by women (f) and men (f) that were clear by statementnum
        d <- split(sheet$clarity, list(sheet$statementnum, sheet$gender))
        clar_f_1 <- sum(d$'1.f')/(length(d$'1.f'))
        clar_f_2 <- sum(d$'2.f')/(length(d$'2.f'))
        clar_f_3 <- sum(d$'3.f')/(length(d$'3.f'))
        clar_m_1 <- sum(d$'1.m')/(length(d$'1.m'))
        clar_m_2 <- sum(d$'2.m')/(length(d$'2.m'))
        clar_m_3 <- sum(d$'3.m')/(length(d$'3.m'))
        
        ##opens pdf in which graphs will be saved
        pdf(paste("gender_analysis_", wksheet, ".pdf", sep=""))
        
        ##creates pie graph to represent breakdown of men vs. women
        ##p <- pie(gcount, labels = c("Female", "Male"), main = "Percent Completed Statements by Men and Women")
        
        ##creates grouped bar graph - ALL
        b_gender <- c(rep("Male" , 4) , rep("Female" , 4))
        Condition <- c("Calculation", "Context", "Comparison", "Clarity", "Calculation", "Context", "Comparison", "Clarity")
        b_students <- c(calc_m, context_m, comp_m, clar_m, calc_f, context_f, comp_f, clar_f)
        data <- data.frame(b_gender, Condition, b_students)
        
        g <- ggplot(data, aes(fill=Condition, y=b_students, x=b_gender)) + geom_bar(position="dodge", stat="identity") + xlab("Gender") + ylab("Percent of Statements") + ggtitle("All Statements")
        
        ##creates grouped bar graph - STATEMENT 1
        b_students1 <- c(calc_m_1, context_m_1, comp_m_1, clar_m_1, calc_f_1, context_f_1, comp_f_1, clar_f_1)
        data1 <- data.frame(b_gender, Condition, b_students1)
        
        g1 <- ggplot(data1, aes(fill=Condition, y=b_students1, x=b_gender)) + geom_bar(position="dodge", stat="identity") + xlab("Gender") + ylab("Percent of Statements") + ggtitle("Statement 1")
        
        ##creates grouped bar graph - STATEMENT 2
        b_students2 <- c(calc_m_2, context_m_2, comp_m_2, clar_m_2, calc_f_2, context_f_2, comp_f_2, clar_f_2)
        data2 <- data.frame(b_gender, Condition, b_students2)
        
        g2 <- ggplot(data2, aes(fill=Condition, y=b_students2, x=b_gender)) + geom_bar(position="dodge", stat="identity") + xlab("Gender") + ylab("Percent of Statements") + ggtitle("Statement 2")
        
        ##creates grouped bar graph - STATEMENT 3
        b_students3 <- c(calc_m_3, context_m_3, comp_m_3, clar_m_3, calc_f_3, context_f_3, comp_f_3, clar_f_3)
        data3 <- data.frame(b_gender, Condition, b_students3)
        
        g3 <- ggplot(data3, aes(fill=Condition, y=b_students3, x=b_gender)) + geom_bar(position="dodge", stat="identity") + xlab("Gender") + ylab("Percent of Statements") + ggtitle("Statement 3")
        
        ##plot(p)
        plot(g)
        plot(g1)
        plot(g2)
        plot(g3)
        dev.off()
}
