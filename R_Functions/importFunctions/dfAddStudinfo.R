dfAddStudinfo <- function(){
       frameName<-variable.env$frameName
       sheetindex<-variable.env$sheetindex
       oldFrame<-get(frameName)
       addFrame<-xlsData.FrameList[[sheetindex]]
       
       newFrame<-merge(addFrame,oldFrame,all=TRUE)
       assign("masterFrame", newFrame, envir=data.env)


       readline(prompt = "press key")
}



        