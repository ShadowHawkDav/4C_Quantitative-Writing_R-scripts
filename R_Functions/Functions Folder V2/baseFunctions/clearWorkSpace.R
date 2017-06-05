clearWorkspace<-function(){
        rm(list = ls(envir=.GlobalEnv),envir=.GlobalEnv)
        sourceAll("./R_Functions/mainFunctions")
}
