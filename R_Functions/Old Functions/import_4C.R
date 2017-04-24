##This script will read a worksheet in 4C format from the Master Excel Data Sheet (MEDS) into a local dataframe. The dataframe will be modified so that each student is associated with a single matrix containing his/her 4C score for a specific assignment. The dataframe will then be added to the master 4C dataframe.

##arguments, 1) excel file name, 2) worksheet name, 3) directory 
import.4C <- function(filename, worksheet, directory = "Data"){
        
        ##This section reads the specified 4C worksheet into a local data frame called "sheet." It pads the "score" column of sheet with leading 0's to the left (up to a width of 4) and then orders the rows of sheet by student IDcode. 
        wb <- loadWorkbook(paste(directory,"/",filename,sep="")) 
        sheet <- readWorksheet(wb, worksheet) 
        sheet <- na.omit(sheet)
        sheet$score <- sprintf("%04d", sheet$score)
        sheet <- sheet[order(sheet$IDcode),]
        
        ##This section converts the "score" column of sheet into 4 seperate columns for "comp", "calc", "context", and "clarity", respectively. 
        j <- 0
        for(i in sheet[,3]){
                j <- j + 1
                temp <- as.numeric(unlist(strsplit(as.character(i),"")))
                sheet[j, 3] <- temp[1]
                sheet[j, 4] <- temp[2]
                sheet[j, 5] <- temp[3]
                sheet[j, 6] <- temp[4]
        }
        sheet[, 3] <- sapply(sheet[, 3], as.numeric)
        colnames(sheet) <- c("IDcode", "statementnum", "comp", "calc", "context", "clarity")
        
        ##This section creates four new variables: 1) IDs, which is the full list of all student IDcodes from the specified worksheet (including repeats), 2) uniqueIDS, which will be used to store a complete list of unique student IDcodes, 3) cccclist, which will be used to store the corresponding list of student's 4C scores in matrix form, and 4) j,a counter initialized at 0. 
        IDs <- as.character((sheet[,1])) ## list of all student ID's
        uniqueIDs <- list()
        cccclist <- list()
        j <- 0

        ##This section loops through UNIQUE student IDs and saves them to the list "uniqueIDS." 
        ##It also converts each student's 4C scores into a single matrix, where the rows of the
        ##matrix are the statement number, and the columns of the matrix are "comp", "calc", 
        ##"context", and "clarity", respectively. Each matrix is added to the list "cccclist".
        for(i in unique(IDs)){
                j <- j+1
                
                uniqueIDs[[j]] <- i
                
                tempframe <- subset.data.frame(sheet, sheet$IDcode==i) 
                tempframe <- tempframe[order(tempframe$statementnum),]
                ccccmatrix <- as.matrix(subset.data.frame(tempframe,select = comp:clarity))
                rownames(ccccmatrix) <- 1:(nrow(ccccmatrix)) 
                cccclist[[j]] <- ccccmatrix
        } 
        
        ##This section binds the two parallel lists (uniqueIDS and cccclist) into a dataframe named "df" with column names of "IDcode" and the specified worksheet name, respectively. 
        df <- as.data.frame(cbind(uniqueIDs, cccclist))
        colnames(df) <- c("IDcode", paste("c_",worksheet,sep=""))
        
        
        
        ##### This section merges the df data frame with the CCCCdf datafame.  The all=TRUE argument specifies that all values will be kept even if they do not appear in both dataframes.
        
        merge(CCCCdf,df,all=TRUE)->CCCCdf      
        CCCCdf<-CCCCdf[,c(colnames(CCCCdf[1]),sort(colnames(CCCCdf[-1])))]
        
        ##### This sections calls upon the save.CCCCdf function to save the CCCCdf data frame in multiple formats to the disk.  This include saving backup versions in /Data/CCCC_backups with a timestamp
        
        save.CCCCdf()
        
        ##### Finally, this last command returns the new CCCCdf to the global environment.
        
        CCCCdf<<-(CCCCdf)    
}

        
         
