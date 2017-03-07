#This sections installs and loads libraries for the R packages necessary for the analysis.  It also sources all of the scripts that will be used for the different procedures    (Note: Jave RunTime Environment must be installed to install the XLConnect Package)

package.load <- function(){
        
        #Packages
        install.packages("lubridate")
        install.packages("gtools")
        install.packages("stringr")
        install.packages("R.utils")
        install.packages("installr") #this package is for windows computers only to fastrack the process of updating to the newest version of R
        install.packages("XLConnect")
        library(XLConnect)
        library(gtools)
        library(lubridate)
        library(installr)
        library(R.utils)
        library(stringr)
        #commands to check out. rbind.fill
        #smartbind
        
        
}