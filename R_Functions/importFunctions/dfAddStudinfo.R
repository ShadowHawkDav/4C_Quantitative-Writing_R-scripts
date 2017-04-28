dfAddStudinfo <- function(){
       frameName<-variable.env$frameName
       sheetindex<-variable.env$sheetindex
       oldFrame<-get(frameName)
       addFrame<-xlsData.FrameList[[sheetindex]]
       
       colnames <-colnames(addFrame)
       
       ##### This sections adds an "a_" to the beginning of each column name in stud.info and then reassigns the new name vector back to the stud.info dataframe.  This will help when keep the student demographic information at the beginning of the CCCCdf data frame when it is sorted.
       y<-0
       for(i in colnames){
               y<-y+1
               if(i=="IDcode") next
               colnames[y]<-paste("a_",i,sep="")
       }
       colnames->colnames(addFrame)
       
       newFrame<-merge(addFrame,oldFrame,all=TRUE)
       assign("masterFrame", newFrame, envir=data.env)

       
       readline(prompt = paste0(names(xlsData.FrameList[sheetindex])," has been successfully added to your data frame\n"))
}



        