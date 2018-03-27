# Author: Sebastian Wolf
#
# Idea: Testing the package of Joey Cheng "promises" for multiple mcr executions in R-3.4.2


.libPaths("x")
path_Store <- Sys.getenv("PATH")
Sys.setenv(
  PATH = paste(
    "C:\\_wolfs25\\bioWARP\\r\\R-Versions\\R-3.4.2\\bin\\x64",
    "C:\\Program Files (x86)\\Java\\jre6\\bin;C:\\Program Files\\Java\\jre6\\bin;C:\\WINDOWS\\system32;C:\\WINDOWS;C:\\WINDOWS\\System32\\Wbem;C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\;C:\\Program Files\\Intel\\WiFi\\bin\\;C:\\Program Files\\Common Files\\Intel\\WirelessCommon\\;C:\\Program Files (x86)\\WebEx\\Productivity Tools;C:\\Program Files (x86)\\PDFtk\\bin\\;C:\\texlive\\2016\\bin\\win32;C:\\Users\\wolfs25\\AppData\\Local\\Pandoc\\;C:\\Program Files\\Internet Explorer;C:\\Users\\wolfs25\\AppData\\Local\\Programs\\Git\\cmd",
    "C:\\RBuildTools/3.4/bin/",
    "C:\\RBuildTools\\3.4\\mingw_64/bin/",
    "C:\\_wolfs25\\bioWARP\\r\\R-Versions\\Rtools\\gcc-4.6.3\\bin",
    sep = ";"
  )
)

options(cores=4, parallel=T,mc.cores=4)


system('where make')
system("g++ -v")

#------------- Install R-packages -------------------

if(!require(devtools)){
	install.packages("devtools",repos="http://cloud.r-project.org/")
	library(devtools)
}
if(!require(here)){
  install.packages("here",repos="http://cloud.r-project.org/")
  library(here)
}

if(!require(promises)){
	devtools::install_github("rstudio/promises")
  devtools::install_github("rstudio/shiny@async")
  Sys.sleep(2)
	library(promises)
  library(async)
}

if(!require(mcr)){
	install.packages(file.path(TFS,"Pkg_mcr/Main/mcr_1.3.tar.gz"),repos=NULL,type="source")
	library(mcr)
}
if(!require(devEMF)){
  install.packages("devEMF")
  Sys.sleep(1)
  library(devEMF)
}

if(!require(Lorelia)){
  install.packages(file.path(TFS,"Pkg_Lorelia\\Releases\\Lorelia V1.1.4\\Lorelia_1.1.4.tar.gz"),type="source",repos=NULL)
  Sys.sleep(1)
  library(Lorelia)
}
library(future)


#---------------------------------------------------
test_fun <- function(x){
  Sys.sleep(5)
  x
}
data("mcpro_sas_results")

hard_way <- future({mcreg(x=mcpro_sas_results[[7]]$method1,y=mcpro_sas_results[[7]]$method2,method.reg = "PaBa")},lazy=T)

options(parallel=F)

easy_way <- future({mcreg(x=mcpro_sas_results[[1]]$method1,y=mcpro_sas_results[[1]]$method2,method.reg = "PaBa")})

f <- future(test_fun("test"))

plan("multisession")
my_list_of_methods <- list("PaBa","PaBa","PaBaLarge")
my_list_of_futures <- lapply(my_list_of_methods,function(x){
  future({mcreg(x=mcpro_sas_results[[7]]$method1,y=mcpro_sas_results[[7]]$method2,method.reg = x)})
})
start.time <- Sys.time()
targets <- lapply(my_list_of_futures, function(x){x %...>% getCoefficients() %...>% print()})
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken

easy_way %...>% print()
