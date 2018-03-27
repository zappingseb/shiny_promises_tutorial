# Promises Tutorial

This is a basic tutorial to use the promises package of Joe Cheng that he 
presented at the EARL conference. The Package can be found on [github](https://github.com/rstudio/promises)

The tutorial will work some basic features of the Package and guide you trough.


# Preparation

## Install R

Please get R>`3.4.2` to run the tutorial. 

## Install necessary Tools

Please install [Rtools](https://cran.r-project.org/bin/windows/Rtools/Rtools34.exe) and
Java development kit [JDK](http://www.oracle.com/technetwork/java/javase/downloads/jdk9-downloads-3848520.html)

You shall add them to your path by using:

```
path_Store <- Sys.getenv("PATH")
Sys.setenv(
  PATH = paste(
    "C:\\_wolfs25\\bioWARP\\r\\R-Versions\\R-3.4.2\\bin\\x64",
    "C:\\Program Files (x86)\\Java\\jre6\\bin",
    "C:\\Program Files\\Java\\jre6\\bin",
    Sys.getenv("PATH"),
    "C:\\RBuildTools/3.4/bin/",
    "C:\\RBuildTools\\3.4\\mingw_64/bin/",
    "C:\\_wolfs25\\bioWARP\\r\\R-Versions\\Rtools\\gcc-4.6.3\\bin",
    sep = ";"
  )
)
```

In here you can see my username and where I installed Rtools and Java. Please change this
part of the tutorial according to your Rtools and Java installation.

## Reset libPath

You might want to run the tutorial in RStudio. Therefore you have to reset your library PATH, as 
RStudio sets it to weird destinations, in my point of view:

```
.libPaths("x")
```

## Set number of cores

```
options(cores=4, parallel=T,mc.cores=4)
```

## Check Tools installation

You may want to check your whole installation. So these two system commands shall give reasonable
outputs:

```
system('where make')
system("g++ -v")

```

# R-packages

The tutorial will be performed with a really difficult regression problem. Therefore you will need the "mcr" package for Regression and a data_set 

# Links

Slides of EARL conf:

https://speakerdeck.com/jcheng5/r-promises

Article about the package:

https://medium.com/@joe.cheng/async-programming-in-r-and-shiny-ebe8c5010790