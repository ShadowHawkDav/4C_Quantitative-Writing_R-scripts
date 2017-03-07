##specifiy new library path for R
.libPaths("./R_Packages")

##load utils package to complete next function
library(utils)
##################################################################################
##packages to be installed
pkglist<-c("gtools","lubridate","stringr","R.utils","XLConnect","Jmisc","data.table","XML")

#################################################################################


##check whether each package is installed, if not, install it.
pkg.install<-function(){
        is.installed <- function(pkg) is.element(pkg, installed.packages()[,1])
        for(i in pkglist){
                if(!is.installed(i)) {install.packages(i)}
                library(i,character.only = TRUE)
        }
}       
pkg.install()
rm(pkglist)
rm(pkg.install)
sourceAll("./R_Functions")

message("
        
        
        
Welcome to the 4C quantitative writing analysis package.  You can use the tools contained withing this package to collect, clean, and analyze student quantitative writing using 4C scores.")
