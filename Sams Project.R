 Sam's GuassView Analyzer Program
# Version 1.0.0.3
# By Nicholas Ruha & Nicholas Zehm
# 6/16/16

files <- list.files(pattern="\\.out$")


ProcessFiles <-function() { # Read in multiple files
    files <- list.files(pattern="\\.out$")
    #return(as.character(files[1]))
    for(i in length(files)) {
        m <- GaussMatrix(files[i])
        return(m)
    }

}
nameFile <- files[1]

# 'Cu_NCP_tpssh_td.out'
#GaussMatrix <- function(nameFile) { #Process the data
    #regex scan for 'Excited state'
    temp = grep("Excited State ", readLines(nameFile, n=-1)) 
    #import whole txt file
    yaas<-read.delim(nameFile, blank.lines.skip = FALSE)
    #read in the lines provided by the regex, R uses 1:inf vs 0:inf for arrays
    getnum<-yaas[temp-1,] 

    #get positions of values
    evPos <- regexpr("eV", getnum)
    nmPos <- regexpr("nm", getnum)
    fPos <- regexpr("f=", getnum)

    # record values
    ev <- as.numeric(substr(getnum, evPos[1]-8, evPos[1]-2))
    nm <- as.numeric(substr(getnum, nmPos[1]-8, nmPos[1]-2))
    fEqual <- as.numeric(substr(getnum, fPos[1]+2, fPos[1]+7))

    #Build matrix
    m <-cbind(ev,nm,fEqual)
    rownames(m) <-c(1:60)
    colnames(m) <-c('eV', 'nm', 'f=')
    write(m, file = paste(as.character(nameFile),'.csv', sep=''), sep =",")
#}
