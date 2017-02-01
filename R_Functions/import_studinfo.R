##############################################################################################
###########################################
#This script will read the stud.info worksheet from the Master Excel Data Sheet (MEDS).  It will then scan the CCCCdf to see what IDcodes are unique and add those as needed.  Finally, it will import all the student demographic info associated with the new IDcodes.  Each unique student not already in CCCCdf will be added as a new row.  Student demographic information that is already present will have values added that correspond to the new imported IDcodes.  If there is a unique piece of demographic data present in stud.info, then it will be added a a new column in CCCCdf with corresponding values for each student.  

#To run this script, open it in the base directory of the Rstudio project folder.  You will also need to make sure the course_assignmentlist.txt is in the "supporting files" folder"

#Make sure the MEDS is in the "Data" folder of the project

###########################################
##############################################################################################

#inputs, 1) name of Master Excel Data sheet (MEDS)


import.studinfo <- function(filename, directory = "Data"){
        
        
        ##### This section reads the CCCdf dataframe that was previously saved as an RData object to the disk.  It is loaded into the current object environment and stored as the object CCCCdf.  This will overwrite the CCCCdf created in the previous command.        

       #CCCCdf <- readRDS("./Data/CCCCdf.Rdata") 
        
        
        ##### This sections opens the Excel workbook specified in the function arguments and reads the stud.info worksheet into a new dataframe called stud.info.  Finally it sorts stud.info based on IDcode 
        wb <- loadWorkbook(paste(directory,"/",filename,sep=""))  
        stud.info <- readWorksheet(wb,"stud.info")
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

        