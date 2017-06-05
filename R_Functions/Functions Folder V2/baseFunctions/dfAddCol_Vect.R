dfAddCol_Vect<-function(){
        cat("\014")
        message("- The dfAddCol_Vect function will take a column of data in which there are multiple values for each IDcode, compile those values into a single vector and then attach that column of vectors to another data frame (primary data frame). \n
- This is appropriate when you have data in a single column with multiple values per student such as annotation data for a 4C matrix.\n
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

                        message("The data frame you selected contains the following columns . . .")
                        colnames<-data.frame(ColName=names(secondFrame))
                        print(colnames)
                        newcolnum<-as.numeric(readline(message("select the number that corresponds to the column that you would like to add to your primary data frame.   ")))
                        vectList<-list()
                        newFrame<-data.frame(a=character())
                        df<-subset(secondFrame, select = c(1,newcolnum))
                        j<-0
                        for(i in unique(df[,1])){
                                j<-j+1
                                a<-filter(df, IDcode == i)
                                vect<-as.vector(a[,2])
                                newFrame[j,1]<-i
                                newFrame$b[[j]]<-vect
                        }
                        colname<-readline(message("what is the name you want to the assign to the new column you are adding? \n"))
                        names(newFrame)<-c("IDcode",colname)
                        df2 <-merge(primaryFrame,newFrame,all=TRUE)
                        assign(frameName, df2, envir=.GlobalEnv)
                        message(" -The column you selected has been added to your primary data frame. \n -Run this function again if you would like to add another column to your primary df")
                }
        } else {message("a data frame with that name does not exist")}
}
