#############################################################################################
###########################################
#This script will read a worksheet downloaded from CAMINO and incorporated into the Master Excel Workbook (MEW).  The worksheet containing the CAMINO doenload will be added to the master 4C data frame (CCCCdf).  Each unique student not already in CCCCdf will be added as a new row.  Each unique assignment from CAMINO will be appended with the course year and then added to CCCCdf as a new collumn.  

#To run this script, open it in the base directory of the Rstudio project folder.  You will also need to make sure the course_assignmentlist.txt is in the "supporting files" folder"

#Make sure the MEW file is in the "Data" folder of the project

###########################################
##############################################################################################

##inputs, 1) excel file name, 2) worksheet name, 3) directory



import.camino <- function(filename, worksheet, directory = "Data"){

##### This section reads the CCCdf dataframe that was previously saved as an RData object to the disk.  It is loaded into the current object environment and stored as the object CCCCdf.        
       
        # CCCCdf<-readRDS(paste("./",directory,"/","CCCCdf.RData",sep=""))


##### This sections opens the excel workbook specific in the function argument using an R package called "XL Connect."  It then reads worksheet specified and creates a dataframe from that worksheet called "camino.sheet."  The final command sorts the data frame by student IDcode
        wb <- loadWorkbook(paste(directory,"/",filename,sep=""))  
        camino.sheet <- readWorksheet(wb,worksheet)
        camino.sheet <- camino.sheet[order(camino.sheet$IDcode),]
        camino.sheet.colnames <-colnames(camino.sheet)

        ##### This sections adds an "a_" to the beginning of each column name in stud.info and then reassigns the new name vector back to the stud.info dataframe.  This will help when keep the student demographic information at the beginning of the CCCCdf data frame when it is sorted.
        y<-0
        for(i in camino.sheet.colnames){
                y<-y+1
                if(i=="IDcode") next
                camino.sheet.colnames[y]<-paste("b_",i,sep="")
        }
        camino.sheet.colnames->colnames(camino.sheet)
        
        

        ##### This section merges the camino.sheet dataframe with the CCCCdf datafame.  the by= argument specifies that entries will be match by idcode.  The all=TRUE argument specifies that all values will be kept even if they do not appear in both dataframes.
        
        merge(CCCCdf,camino.sheet,all=TRUE)->CCCCdf      
        CCCCdf<-CCCCdf[,c(colnames(CCCCdf[1]),sort(colnames(CCCCdf[-1])))]
        
        
        ##### This sections calls upon the CCCCdf.save function to save the CCCCdf data frame in multiple formats to the disk.  This include saving backup versions in /Data/CCCC_backups with a timestamp
        
        save.CCCCdf()
        
        ##### Finally, this last command returns the new CCCCdf to the global environment.
        
        CCCCdf<<-(CCCCdf)    
        

}
