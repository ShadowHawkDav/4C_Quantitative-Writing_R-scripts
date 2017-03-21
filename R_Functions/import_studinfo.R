import.studinfo <- function(file, sheet, directory = "Data"){
        
        
        ##### This sections opens the Excel workbook specified in the function arguments and reads the stud.info worksheet into a new dataframe called stud.info.  Finally it sorts stud.info based on IDcode 
        wb <- loadWorkbook(paste("./",directory,"/",file,sep=""))  
        stud.info <- readWorksheet(wb,sheet)
        stud.info <- stud.info[order(stud.info$IDcode),]
        stud.info.colnames <-colnames(stud.info)
        
        ##### This sections adds an "a_" to the beginning of each column name in stud.info and then reassigns the new name vector back to the stud.info dataframe.  This will help when keep the student demographic information at the beginning of the CCCCdf data frame when it is sorted.
        y<-0
        for(i in stud.info.colnames){
                y<-y+1
                if(i=="IDcode") next
                stud.info.colnames[y]<-paste("a_",i,sep="")
        }
        stud.info.colnames->colnames(stud.info)
        

        ##### This section merges the stud.info dataframe with the CCCCdf datafame.  The all=TRUE argument specifies that all values will be kept even if they do not appear in both dataframes.

        merge(CCCCdf,stud.info,all=TRUE)->CCCCdf      
        CCCCdf<-CCCCdf[,c(colnames(CCCCdf[1]),sort(colnames(CCCCdf[-1])))]
        
        ##### This sections calls upon the CCCCdf.save function to save the CCCCdf data frame in multiple formats to the disk.  This include saving backup versions in /Data/CCCC_backups with a timestamp
        
        save.CCCCdf()
        
        ##### Finally, this last command returns the new CCCCdf to the global environment.
        
    CCCCdf<<-(CCCCdf)    
}

        