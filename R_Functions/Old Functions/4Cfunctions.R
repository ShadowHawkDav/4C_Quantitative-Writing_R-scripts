#4C Coding analysis and workflow functions



##############    1) Package list to load into excel   ###############################

## read excelsheets into R
## Excel packages require java to be installed on local machine to work properly
        install.packages("XLConnect")
        install.packages("xlsx")
        library(xlsx)  
        library(XLConnect)

#############     2) Load xlsx workbook file and save worksheets as a list of dataframesets
        
        
        load.4CWB <- function(filename){ #funtion to load excel individual worksheets
                #setwd("~/Google Drive/R/4C coding/DataFiles")
                
                wb <- loadWorkbook(filename) 
                namelist <- getSheets(wb)
                sheetlist <- list()
                for(i in namelist[-1]){
                        sheet <- readWorksheet(wb,sheet=i)
                        sheetlist[[i]] <- sheet
                        
                }
               sheetlist
        
        }
        
        
        
##########################################################################################################
       # All content down here works as a script file
        
## load excel worksheets into dataframe (except student ID master) from CSV files
        setwd("C:/Users/David McMillan/Google Drive/R/4C coding")
        directory <- "DataFiles"
        studentinfo <- read.csv(paste(directory,"/studentinfo.csv",sep=""))
        assignmentseklab <- read.csv(paste(directory,"/eklab.csv",sep=""))
        assignmentscamino <- read.csv(paste(directory,"/camino.csv",sep=""))
        assignmentstrlab <- read.csv(paste(directory,"/trlab.csv",sep=""))
        
        #sort each of the datafremas by studentID
        studentinfo <- studentinfo[order(studentinfo$IDcode),]
        assignmentseklab <- assignmentseklab[order(assignmentseklab$IDcode),]
        assignmentscamino <- assignmentscamino[order(assignmentscamino$IDcode),]
        assignmentstrlab <- assignmentstrlab[order(assignmentstrlab$IDcode),]
        
        #create vectors of dataframe element names and find length of each
        namesinfo <- names(studentinfo)
        namescamino <- names(assignmentscamino)
        
        #Create master dataframe that will eventyally contain all student data
        CCCCdf<- studentinfo
        
        #Creation of dataframe with matrix of 4C data for EK lab
        IDek <- unique(assignmentseklab[,1])  
        IDek <- as.character(IDek)   #create a character vector of all different student IDs
        ek.4Cdf <- data.frame(IDcode=IDek) #dataframe to eventually store 4C scores (col1 is Student Ids)
        cccclist <- list() #list to store 4c matrices (will be added to dataframe)
        j <- 0
        for(i in IDek){
                j <- j+1
                print(i)
                tempframe <- subset.data.frame(assignmentseklab,assignmentseklab$IDcode==i)
                ccccmatrix <- as.matrix(subset.data.frame(tempframe,select = comp:clarity))
                rownames(ccccmatrix) <- 1:(nrow(ccccmatrix)) #statement number as 4C matrix rowname
                cccclist[[j]] <- ccccmatrix
        }  
        
        ek.4Cdf$ek4Cmatrix <- cccclist
        
        
        #Creation of dataframe with matrix of 4C data for TR lab
        IDtr <- unique(assignmentstrlab[,1])  
        IDtr <- as.character(IDtr)   #create a character vector of all different student IDs
        tr.4Cdf <- data.frame(IDcode=IDtr) #dataframe to eventually store 4C scores (col1 is Student Ids)
        cccctrlist <- list() #list to store 4c matrices (will be added to dataframe)
        j <- 0
        for(i in IDtr){
                j <- j+1
                print(i)
                tempframe <- subset.data.frame(assignmentstrlab,assignmentstrlab$IDcode==i)
                cccctrmatrix <- as.matrix(subset.data.frame(tempframe,select = comp:clarity))
                rownames(cccctrmatrix) <- 1:(nrow(cccctrmatrix)) #statement number as 4C matrix rowname
                cccctrlist[[j]] <- cccctrmatrix
        }  
        
        tr.4Cdf$tr4Cmatrix <- cccctrlist
        
        
        
                
        #ForLoop to add columns from 4C assignments and camino to CCCCdf frame, matches with same IDcode
        for(i in namescamino){
                if (i=="IDcode") {  
                        #empty If statement to skip adding duplicate column to CCCCdf for IDcode
                } else {
                        CCCCdf[,i] <- assignmentscamino[,i][match(CCCCdf$IDcode,assignmentscamino$IDcode)]
                }

        }
        #statements to match 4C matrices for EK and TR lab to CCCCdf dataframe
        CCCCdf$enzymekin4C <- ek.4Cdf[,2][match(CCCCdf$IDcode,ek.4Cdf$IDcode)]
        CCCCdf$transcription4C <- tr.4Cdf[,2][match(CCCCdf$IDcode,tr.4Cdf$IDcode)]
        