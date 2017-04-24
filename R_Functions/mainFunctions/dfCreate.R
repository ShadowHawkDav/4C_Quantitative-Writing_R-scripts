dfCreate<-function(frameName = "CCCCdf") {
        data.env<-new.env()
        variable.env<-new.env()
        source("./R_Functions/importFunctions/dfAdd4C.R",local=TRUE)
        source("./R_Functions/importFunctions/dfAddCamino.R",local=TRUE)
        source("./R_Functions/importFunctions/dfAddStudinfo.R",local=TRUE)
        
        if(!exists(frameName)){assign(paste(frameName),data.frame(IDcode=character()),envir=globalenv())}
        
        masterFrame<-get(frameName)
        assign("frameName",frameName,envir = variable.env)
        assign("masterFrame",masterFrame,envir=data.env)
        
        cat("\014")
        message("The dfCreate function will allow you to add data imported from an Excel worksheet into a an existing or newly created data frame. 
\n
The argument specified for this function is the name of the dataframe you want to create/expand.  You will encounter an error if you specificy the name of an object that is not a data frame. 
\n
If the name you specify does not already exist, a new data frame will be created.  A dataframe called CCCCdf will be created if no dataframe name was specified when you ran the funtion")
        readline("(press enter to continue)")

        loop<-"yesloop"
                while(loop=="yesloop"){
                cat("\014")
                choice<-readline(paste0("Would you like to add new data to the data frame, ",frameName," now? \n (y or n)  "))
                if(choice=="y"){
                        message("The following list shows the name and datatype of each of the dataframes loaded.")        
                        importlist<-importResults.frame[,1:2]
                        print(importlist)
                        sheetindex<-as.numeric(readline(message("Please enter the line number of the sheet you would like to add to CCCCdf.   ")))
                        assign("sheetindex",sheetindex,envir = variable.env)
                        sheettype<-importlist[sheetindex,2]
                        if(sheettype=="studinfo"){   dfAddStudinfo()}
                        else if(sheettype=="4C"){dfAdd4C()} 
                        else if(sheettype=="camino"){dfAddCamino()} 
                        else {message("unrecognized sheet type")}
                       
                        
                        frame<-data.env$masterFrame
                        
                        newMasterFrame<-frame[,c(names(frame[1]),sort(names(frame[-1])))]
                        
                        
                        assign(frameName, newMasterFrame, envir=.GlobalEnv)       
                        
                        
                } else {
                              
                        choice2<-readline("Would you like to exit the dfCreate function now? \n (y or n)  ")
                        if (choice2=="y"){loop<-"noloop"}
                        if (choice2=="n"){loop<-"yesloop"}
               } 
       }
}        
