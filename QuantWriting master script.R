#Master 4C Coding analysis and workflow functions

#############################################################################
#Feature to add:

#1) notes section before each script block that explains function and defines function arguments

#2) Use defined list of assignments to rename columns in camino download to be in shortened standardized naming and appended with year 

#3) GUI interface with web-based delivery(shiny)



#############################################################################


#########   Analysis Workflow  #########

#1) Workspace preparation.  Run the commands below to download and install the necessary R packages of the 4C analysis.  Note: Make sure Java RunTime Environment is installed before continuning
        #init configuration
        install.packages("Jmisc")
        library(Jmisc)
         #Source all scripts files in R_functions directory
        sourceAll("./R_Functions")

        #Load necessary packages
        package.load()
     
        #Use this command to create a blank CCCCdf (be very careful with using it)
        ###### DO NOT RUN THESE COMMANDs UNLESS YOU ARE CETAIN #######
        CCCCdf <- data.frame(IDcode=character())
        saveRDS(CCCCdf,"./Data/CCCCdf.RData")   
        CCCCdf<-readRDS("./Data/CCCCdf.RData")
       
        
#2) Data Import
###################### Student Demographic Info Import #############################
        
        #Process - Use the following command to import student information from an excel file.  The name of the worksheet with the student information must be "stud.info"  See the Project documentation for specific information about how to structure the student data within the file.  
        
        
        #Instructions - Change the XXX below to match the name of the excel file where the student data is located (don't remove the quotes).  The default folder for the data file is /Data.  Use directory="XXX" as an additional argument if the data is located in a different folder.

        import.studinfo("test2.xlsx") 
        

########################### CAMINO data Import ##########################
        
        #Process Overview - Use the following command to import a single worksheet containing a student assignment data exported from CAMINO.  The worksheet will be added to CCCCdf master dataframe by matching student IDcodes in the CAMINO worksheet with IDcodes already in CCCCdf.  Make sure to read the project file documentation for specific information about how to structure the student data within the file.  
        
        #Instructions - Change the values below to match the names of the file and worksheet that you would like to import.  Run the function in the R console.
        #filename - name of the Excel workbook file (be sure to include "" and .xlsx)
        #worksheet - name of the directory in the file that contains the properly formatted student data downloaded from CAMINO.
        #directory - the name of the directory where the file is located.  Default is "Data".  No need to specify the directory if you are using the default.  Otherwise, use directory="XXXX"  
        
        import.camino("test3.xlsx","assign.camino172") 
        
        
        
        import.4C("test2.xlsx","assign.eklab16")
        import.4C("test3.xlsx","assign.eklab17")
        import.4C("test3.xlsx","assign.trlab17")
        
        
                
#2) Analysis
        
#3) Graphing
        
#4) Output
        
        
        