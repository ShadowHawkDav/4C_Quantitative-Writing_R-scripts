#4C Coding analysis and workflow functions


#1) External files to load for analysis--(Note: Jave RunTime Environment must be installed)

        #Packages
        install.packages("XLConnect")
        library(XLConnect)
        #Script files to source
        source("./R_Functions/load_4CExcelwb.R")
        source("./R_Functions/digit_extraction.R")
 
        load_4CExcelwb("4CAssignmentMaster_extract_individual_digits.xlsx")
               
#2) Analysis
        
#3) Graphing
        
#4) Output