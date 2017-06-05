dfAddCamino <- function(){

        ##wb <- loadWorkbook(paste(directory,"/",filename,sep=""))
        ##camino.sheet <- readWorksheet(wb,worksheet)
        ##camino.sheet <- camino.sheet[order(camino.sheet$IDcode),]
        ##camino.sheet.colnames <-colnames(camino.sheet)

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
                colnames[y]<-paste("b_",i,sep="")
        }
        colnames->colnames(addFrame)

        newFrame<-merge(addFrame,oldFrame,all=TRUE)
        assign("masterFrame", newFrame, envir=data.env)


        readline(prompt = paste0(names(xlsData.FrameList[sheetindex])," has been successfully added to your data frame\n"))



        ##### This section merges the camino.sheet dataframe with the CCCCdf datafame.  the by= argument specifies that entries will be match by idcode.  The all=TRUE argument specifies that all values will be kept even if they do not appear in both dataframes.

        ##merge(CCCCdf,camino.sheet,all=TRUE)->CCCCdf
        ##CCCCdf<-CCCCdf[,c(colnames(CCCCdf[1]),sort(colnames(CCCCdf[-1])))]


        ##### This sections calls upon the CCCCdf.save function to save the CCCCdf data frame in multiple formats to the disk.  This include saving backup versions in /Data/CCCC_backups with a timestamp

        ##save.CCCCdf()

        ##### Finally, this last command returns the new CCCCdf to the global environment.

        ##CCCCdf<<-(CCCCdf)


}
