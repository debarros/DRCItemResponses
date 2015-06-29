#This is the function that breaks apart the data and adds the desired variables

AddVariables = function(inFile){
  #Remember that inFile does not actually hold the uploaded file.  It just holds info about the uploaded file.
  #The path to the uploaded file is stored in inFile$datapath
  x = read.csv(inFile$datapath, stringsAsFactors = FALSE) #load the file  
  
  #clean it up
  x[,-1] <- gsub('"', "", as.matrix(x[,-1])) #remove all quotes
  x[,-1] <- gsub('=', "", as.matrix(x[,-1])) #remove all equals signs
  
  #determine the structure of the test
  MCQs = nchar(x$McResponseArray[1]) #set the number of MC questions
  CRQs = c(0,as.numeric(gregexpr("\\.", x$CrResponseArray[1])[[1]])) #find the boundaries of all the CR question scores
  #Note that . is a special character in regular expressions, so it must be escapped with \
  #However, \ is a special character in R, so it must be escaped with another \
  
  #create variables for all the MC questions
  for (i in 1:MCQs){
    assign(paste0("Q",i), gsub("D", 4, gsub("C", 3,gsub("B",2,gsub("A",1,substr(x$McResponseArray, i, i))))))
  }
  
  #create variables for all the CR questions
  for (i in 1:(length(CRQs)-1)){
    assign(paste0("Q",i+MCQs), substr(x$CrResponseArray, CRQs[i]+1, CRQs[i+1]-1))
  }
  
  #create a single variable for the student name
  LastFirst = paste0(x$StudentLastName, ", ", x$StudentFirstName, " ", x$StudentMiddleInitial)
  
  # combine the new variables with the existing data
  z = do.call(cbind, mget(c("LastFirst","x",paste0("Q",1:(MCQs+length(CRQs)-1)))))
  
  #fix the variables names
  Varnames = colnames(z)
  Varnames = gsub("x.","", Varnames)
  colnames(z) = Varnames
  
  return(z)
}