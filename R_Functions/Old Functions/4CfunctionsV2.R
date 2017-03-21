#4C Coding analysis and workflow functions



##############    1) Package list to load into excel   ###############################

        ## Excel packages require java to be installed on local machine to work properly
        #install.packages("XLConnect")
        #install.packages("xlsx")
        #library(xlsx)  
        #library(XLConnect)

#############     2) Load xlsx workbook file, save worsheets and create master dataframe  #####
        

load.4CWB <- function(filename, directory = "DataFiles"){ 
#1)    Load all worksheets from excel file as dataframes and name them same as Excel         
        wb <- loadWorkbook(paste(directory,"/",filename,sep=""))  #load workbook (XLConnect Package)
        namelist <- getSheets(wb) #create list of Excel Sheet names
        j<-1 # Loop counter
        for(i in namelist[-1]){ #repeat loop for each sheet in Excel
                j<- j+1 
                sheet <- readWorksheet(wb,sheet=i) # Read worksheet from excel
                assign(namelist[j],sheet)       #Assign sheet dataframe to name in namelist 
        }
        
#2)    Create empty master dataframe and populate it with basic student info        
        CCCCdf<- stud.info
        
#3)     Sort each of the datafremas by studentID in case they are out of order
        stud.info <- stud.info[order(stud.info$IDcode),]
        assign.eklab <- assign.eklab[order(assign.eklab$IDcode),]
        assign.camino <- assign.camino[order(assign.camino$IDcode),]
        assign.trlab <- assign.trlab[order(assign.trlab$IDcode),]
        
        
        
#4)     Add individual Camino assignments scores to master data frame, matched by IDCode  ######
        namescamino <- names(assign.camino)
        for(i in namescamino){
                if (i=="IDcode") {  
                        #skip adding column to CCCCdf to avoid having multiple columns with IDCode####
                } else {
                        CCCCdf[,i] <- assign.camino[,i][match(CCCCdf$IDcode,assign.camino$IDcode)]
                }
        }

#5)     Create list of matrices of student 4C scores for EK Lab and add to CCCCdf
        IDek <- as.character((assign.eklab[,1]))        #List of Unique student IDs for Ek lab (type:character)
        ek.4Cdf <- data.frame(IDcode=IDek) #Empty dataframe for 4C scores with ID in first column
        cccclist <- list() #list to store 4c matrices (will be added to dataframe)
        j <- 0
        for(i in IDek){
                j <- j+1
                tempframe <- subset.data.frame(assign.eklab,assign.eklab$IDcode==i) #subset single student 4C matrix
                ccccmatrix <- as.matrix(subset.data.frame(tempframe,select = comp:clarity))
                rownames(ccccmatrix) <- 1:(nrow(ccccmatrix)) #statement number as 4C matrix rowname
                cccclist[[j]] <- ccccmatrix
        }  
        ek.4Cdf$ek4Cmatrix <- cccclist #Assign list of matrices to 2nd column of ek.4Cdf
        CCCCdf$ek4C <- ek.4Cdf[,2][match(CCCCdf$IDcode,ek.4Cdf$IDcode)] #Add ek4C matrix to CCCCdf (IDcode matched)
        
        
#6)     Create list of matrices of student 4C scores for TR Lab and add to CCCCdf
        IDtr <- as.character((assign.trlab[,1]))        #List of Unique student IDs for TR lab (type:character)
        tr.4Cdf <- data.frame(IDcode=IDtr) #Empty dataframe for 4C scores with ID in first column
        cccclist <- list() #list to store 4c matrices (will be added to dataframe)
        j <- 0
        for(i in IDtr){
                j <- j+1
                tempframe <- subset.data.frame(assign.trlab,assign.trlab$IDcode==i) #subset single student 4C matrix
                ccccmatrix <- as.matrix(subset.data.frame(tempframe,select = comp:clarity))
                rownames(ccccmatrix) <- 1:(nrow(ccccmatrix)) #statement number as 4C matrix rowname
                cccclist[[j]] <- ccccmatrix
        }  
        tr.4Cdf$tr4Cmatrix <- cccclist #Assign list of matrices to 2nd column of ek.4Cdf
        CCCCdf$tr4C <- tr.4Cdf[,2][match(CCCCdf$IDcode,tr.4Cdf$IDcode)] #Add tr4C matrix to CCCCdf (IDcode matched)
        
        
#7      Assign master dataframe(CCCCdf) to global environment        
        CCCCdf <<- CCCCdf
}