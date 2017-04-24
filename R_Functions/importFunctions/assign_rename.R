assign_rename<-function(directory="Data"){
        
        dfname<-readline(prompt="What is the name of the 4C dataframe?")
        df<-get(dfname)
        directory<-"Data"
        wb<-loadWorkbook("Data/assignmentNameIndex.xlsx") #load wb with assignment name list
        sheet<-readWorksheet(wb,1) #read sheet with assignment names
        namesList<-colnames(df) #get assignment names from CCCCdf
        assignNameBank<-na.omit(sheet,sheet$caminoCode) #remove NA from Assignment codes in names sheet
        for(i in assignNameBank$caminoCode){
                oldNameColNum<-grep(i,namesList)
                #print(i)
                newNameRowNum<-grep(i,assignNameBank$caminoCode)
                #print(rownum)
                namesList[oldNameColNum]<-paste("b_",assignNameBank[newNameRowNum,"rAssignmentName"],sep = "")
                #sub(i,assignNameBank[newNameRowNum,"rAssignmentName"],namesList)
        }
        colnames(df)<-namesList
        df<-df[,order(names(df))]
        assign(dfname,df)       
}