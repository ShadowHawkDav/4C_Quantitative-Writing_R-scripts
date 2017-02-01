
save.CCCCdf<-function(directory="Data"){

#### This function saves the new CCCCdf as an .RData object and an excel workbook in the "Data" folder of the project.  The first command saves the dataframe as a .RData file to the disk.  The next commands a)create the excel workbook, b)create a new worksheet, c)Save the dataframe to the worksheet, and d)save the workbook ot the disk

###Each file is appended with the system date and/or time.  

#1) CCCCdf.Rdata
saveRDS(CCCCdf,paste(directory,"/","CCCCdf.RData",sep=""))

#2) CCCCdf.Rdata with month and day
saveRDS(CCCCdf,paste(directory,"/","CCCCdf_",month(Sys.Date()),"-",day(Sys.Date()),"-",year(Sys.Date()),".RData",sep=""))

#3) CCCCdf with hour and minute in file name into backup folder
saveRDS(CCCCdf,paste(directory,"/CCCCdf_backups/","CCCCdf_",Sys.Date(),"_",hour(Sys.time()),"-",minute(Sys.time()),".RData",sep=""))

#4) Saved CCCCdf as Excel file for easy viewing
writeWorksheetToFile(paste(directory,"/","CCCCdf_",month(Sys.Date()),"-",day(Sys.Date()),"-",year(Sys.Date()),".xlsx",sep=""),CCCCdf,sheet="CCCCdf")

#5) CCCCdf saved as Excel file in backup folder
writeWorksheetToFile(paste(directory,"/CCCCdf_backups/","CCCCdf_",Sys.Date(),"-",hour(Sys.time()),"-",minute(Sys.time()),".xlsx",sep=""),CCCCdf,sheet="CCCCdf") 



message("The CCCCdf data frame has been saved in both Excel and .RData format.")

}