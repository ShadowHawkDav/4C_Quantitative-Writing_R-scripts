dfAddCol_Value<-function(){
        cat("\014")
        message("-The dfAddCol function will allow you to specify a primary data frame and then add an individual column from a second data frame to your primary df.\n
- If your priamry data frame does not already exist, you will need to create it using the dfCreate function.\n")
        frameName<-readline("What is the name of your primary data frame?")

        if(is.data.frame(get(frameName))){
                primaryFrame<-get(frameName)

                cat("\014")
                choice<-readline(message("Do you want to add a column from another data frame to your primary frame now? \n (y or n)  "))
                if(choice=="y"){
                        message("The following list shows a list of the data frames that are currently part of the Master excel file.")
                        frameList<-importResults.frame[,1:2]
                        print(frameList)
                        secondFramenum<-as.numeric(readline(message("For the column of data you would like to add to your primary data frame, \n please enter the numer that corresponds to the data frame where your column is located   ")))
                        secondFrame<-xlsData.FrameList[[secondFramenum]]


                        message("The data frame you selected containt columns the following columns . . .")
                        colnames<-data.frame(ColName=names(secondFrame))
                        print(colnames)
                        newcolnum<-as.numeric(readline(message("select the number that corresponds to the column that you would like to add to your primary data frame.   ")))

                        newFrame<-subset(secondFrame, select = c(1,newcolnum))
                        df <-merge(primaryFrame,newFrame,all=TRUE)
                        assign(frameName, df, envir=.GlobalEnv)
                        message(" -The column you selected has been added to your primary data frame. \n -Run this function again if you would like to add another column to your primary df")
                }
        } else {message("a data frame with that name does not exist")}
}
