dfRead<-function(){
        message("This function will read a previously saved data frame from the disk.  The name of the data frame will be the same as the file name without the appended data or initials.")
        
        filelist<-data.frame(FileName=list.files("./Data/DataFrames"))
        message("Below is the list of data frames that are currently saved to the disk.")
        print(filelist)
        fileindex<-as.numeric(readline("Please enter the line number of the data frame you want to open.   "))
        filename<-filelist[fileindex,1]
        
        changename<-readline("Do you want to give this data frame a different name? (y or n) ")
        if(changename=="y"){frameName<-readline("What is the name of the new data frame?")}
        else {frameName<-filename;frameName<-sub("_.*","",frameName) }
        
        assign(frameName,readRDS(paste0("./Data/DataFrames/",filename)), envir=.GlobalEnv)
                
        message("The frameName data frame has added to the environment.")
}