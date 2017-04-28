##The purpose of this function is to open the specified Excel file and read each tab in the file into a separate dataframe with the name of the Excel worksheet


xlsImport<-function(){

#SECTION 1:  Determine the correct name of the EXCEL data file to import        
        x<-0
        cat("\014") 
        while(x==0){
                message("Please be sure that the data file is located in the Data folder")
                message("The default data file is 4C_Master Excel Datasheet.xlsx")
                import.choice<-readline(prompt="Is this file you would like to import (y or n)")
                if(import.choice=="y"){
                        file.name<-"4C_Master Excel Datasheet.xlsx"
                        x<-x+1
                } else if(import.choice=="n"){
                        file.name<-readline(prompt = "What is the name of your data file (include file extension)?")
                        x<-x+1
                } else message("Please enter y or n")
        
        }

#SECTION2: Open the EXCEL workbooks and get a list of the worksheets and then remove all of hte character string after the first "_" which leaves a list of the type of sheets to be imported.
        
        wb <- loadWorkbook(paste("./Data/",file.name,sep=""))  
        sheet.names<-getSheets(wb)
        sheet.typelist<-sub("_.*","",sheet.names)
        
        
#SECTION3: Reach each worksheet and then read it into a dataframe.  At the same time create a basic log of the import process to verify that each sheet was imported correctly.  Output is a LIST of dataframes for each worksheet in the EXCEL file and a DATAFRAME with a summary of the names and the types of sheets imported.        
        
        importResults.frame<-data.frame(Sheet.Name=character(),Import.Type=character(),Columns=numeric(),Rows=numeric(),Notes=character(),stringsAsFactors = FALSE)
        xlsData.FrameList<-list()
        y<-0
        for (i in sheet.names){
                y<-y+1
                sheet.pos<-getSheetPos(wb,i)
                sheet.type<-sheet.typelist[sheet.pos]
                      
                if(sheet.type=="studinfo"){
                        new.frame<- readWorksheet(wb,i)  #%>% na.omit()
                        note<-"studinfo worksheet imported"
                } else if(sheet.type=="camino"){
                        new.frame<- readWorksheet(wb,i)  #%>% na.omit()
                        note<-"camino worksheet imported"
                } else if(sheet.type=="4C"){
                        new.frame<- readWorksheet(wb,i)  %>% na.omit()
                        new.frame$score <- sprintf("%04d", new.frame$score)
                        cols<-ncol(new.frame)
                        oldcolnames<-colnames(new.frame)
                        #scoreframe<-data.frame(IDcode=new.frame[,1])
                        j <- 0
                        for(k in new.frame[,3]){
                                j <- j + 1
                                temp <- as.numeric(unlist(strsplit(k,"")))
                                new.frame[j,cols+1] <- temp[1]
                                new.frame[j,cols+2] <- temp[2]
                                new.frame[j,cols+3] <- temp[3]
                                new.frame[j,cols+4] <- temp[4]
                                #new.frame[j,3] <- temp[1]
                                #new.frame[j,4] <- temp[2]
                                #new.frame[j,5] <- temp[3]
                                #new.frame[j,6] <- temp[4]
                        }
                        
                        colnames(new.frame) <- c(oldcolnames,"comp", "calc", "context", "clarity")
                        note<-"4C worksheet imported"
                
                } else {
                        new.frame<- readWorksheet(wb,i)  %>% na.omit()
                        note<-"unrecognized worksheet imported"        
                }
                        
                cols<-ncol(new.frame)
                rows<-nrow(new.frame)
                xlsData.FrameList[[i]]<-new.frame
                newVector<-c(i,sheet.type,cols,rows,note)
                importResults.frame[y,]<-newVector
                 
        }

        
        
cat("\014")        
assign("xlsData.FrameList", xlsData.FrameList, envir=.GlobalEnv)
assign("importResults.frame", importResults.frame, envir=.GlobalEnv)
print(importResults.frame)
x <- readline("See the list above for import results!\n(press enter to continue)")

}
        
                
                
        