dfAdd4C <- function(){
        frameName<-variable.env$frameName
        sheetindex<-variable.env$sheetindex
        oldFrame<-get(frameName)
        addFrame<-xlsData.FrameList[[sheetindex]]
        #SECTION 1: This section asks the user whether or not he/she would like to assign an annotation as the row name for each of the rows in each student matrix.  It then presents a list of the column names to the user to select which annoatation will be used.  If no annotation is selected each row is named with the statement number.
         message("You have chosen to attach a matrix of 4C data to frameName.  BY default, the rows of each matrix will be labeled with the statement number.  \n  \n
would you like use a different column to label the rows of the 4C data matrix?\n")
        annotateCol<-readline(prompt="(y or n)   ")
        if(annotateCol=="y"){
                namelist<-names(addFrame)
                print(namelist)
                message("\n The list of column titles for the 4C data is shown above.  Enter the number that corresponds to the column that you would like to use to annotate the rows of the 4C matrix. \n \n Enter 0 if you would like to use statement number as row labels in the 4C matrix")
                annotateCol<-as.numeric((readline(prompt = "Column to use for row annotations- ")))
        
        } else {annotateCol<-0}
                               
#SECTION 2:This section creates four new variables: 1) IDs, which is the full list of all student IDcodes from the specified worksheet (including repeats), 2) uniqueIDS, which will be used to store a complete list of unique student IDcodes, 3) cccclist, which will be used to store the corresponding list of student's 4C scores in matrix form, 4) j,a counter initialized at 0. 
        IDs <- as.character(addFrame[,1]) ## list of all student ID's
        uniqueIDs <- list()
        cccclist <- list()
        j <- 0
        
#SECTION 3:This section loops through UNIQUE student IDs and saves them to the list "uniqueIDS." It also converts each student's 4C scores into a single matrix, where the rows of the matrix are the statement number, and the columns of the matrix are "comp", "calc", "context", and "clarity", respectively. Each matrix is added to the list "cccclist".
        for(i in unique(IDs)){
                j <- j+1
                uniqueIDs[[j]] <- i
                matrixframe <- subset(addFrame, addFrame$IDcode==i) 
                matrixframe <- matrixframe[order(matrixframe$statementnum),]
                ccccmatrix <- as.matrix(subset.data.frame(matrixframe,select = comp:clarity))
                matrixRowNames<-vector()
                f<-0
                if(annotateCol==0){
                        rownames(ccccmatrix) <- 1:(nrow(ccccmatrix))
                } else {
                        for (m in matrixframe[,annotateCol]){
                                f<-f+1
                                matrixRowNames[f]<- m
                        }
                        rownames(ccccmatrix) <- matrixRowNames
                } 
                cccclist[[j]] <- ccccmatrix
        } 
        
#SECTION 4: This section binds the two parallel lists (uniqueIDS and cccclist) into a dataframe named "df" with column names of "IDcode" and the specified worksheet name, respectively.  It also add a c_ to signify that the columns are from a 4C dataset
        addFrame <- as.data.frame(cbind(uniqueIDs, cccclist))
        colnames(addFrame) <- c("IDcode", paste0("b_",importlist[sheetindex,1]))
        addFrame$IDcode<-as.character(addFrame$IDcode)        
        
        ##### This section merges the df data frame with the frameName datafame.  The all=TRUE argument specifies that all values will be kept even if they do not appear in both dataframes.
        
        newFrame<-merge(addFrame,oldFrame,all=TRUE)      
             
        
        assign("masterFrame", newFrame, envir=data.env)

        readline(prompt = paste0(names(xlsData.FrameList[sheetindex])," has been successfully added to your data frame\n"))        
}