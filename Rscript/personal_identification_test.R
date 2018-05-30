###################################################################
## created by Hikaru Watanabe at Tokyo Institute of Technology   ##
## 2018-05-30                                                    ##
## email<watanabe.h.ap@m.titech.ac.jp>                           ##
## R version 3.3.2 (2016-10-31)                                  ##
###################################################################

# Setting working directory
setwd("human_skin_personal_identification")

# Personal identification function 
personal_identification <- function(d.dist.m.query_reference, sample_individual){
  query     <- rownames(d.dist.m.query_reference)
  reference <- colnames(d.dist.m.query_reference)

  rownames(sample_individual) <- as.vector(sample_individual$sample)
  df_query     <- sample_individual[query    ,]
  df_reference <- sample_individual[reference,]
  
  individual <- as.vector(unique(sample_individual$individual))
  
  mat           <- matrix(0,
                          nrow=length(individual),
                          ncol=length(individual))
  rownames(mat) <- individual
  colnames(mat) <- individual
  
  results        <- list()
  results$matrix <- mat
  results$score  <- 0
  score          <- 0
  
  for(q in query){
    
    df_reference_temp   <- subset(df_reference, sample!=q) # Leave the query sample from reference samples (Leave-one-out)
    individual_meandist <- data.frame(individual=NA, distance=NA)
    
    for(ind in individual){
      one_individual           <- subset(df_reference_temp, individual==ind)
      extract_sample           <- as.vector(one_individual$sample)
      distance                 <- mean(d.dist.m.query_reference[q, extract_sample])
      individual_meandist_temp <- data.frame(individual=ind, distance=distance)
      individual_meandist      <- rbind(individual_meandist, individual_meandist_temp)
    }
    
    individual_meandist2 <- na.omit(individual_meandist)
    
    query_individual     <- as.vector(sample_individual[sample_individual$sample == q,2])
    nearest_individual   <- individual_meandist2[which.min(individual_meandist2$distance),1]
    mat[query_individual, nearest_individual] <- mat[query_individual, nearest_individual] + 1
    
    if(query_individual== nearest_individual){
      score = score + 1
    }
    
  }
    
  results$matrix <- mat
  results$score  <- score/(length(query))
  
  return(results)
}

# Demonstration of personal identification.
data                     <- read.table("matrix/test_data.otu", sep="\t",header=T,row.names=1) #Loading OTU table
sample_individual        <- read.table("matrix/test_data.list", sep="\t",header=T) #Loading relational table of sample and individual
d.rate                   <- prop.table(as.matrix(data),2) # Calcurating relative abundance of OTU
d.dist                   <- dist(t(d.rate), method="canberra") # Calcurating distance
d.dist.m.query_reference <- as.matrix(d.dist) # convert to matrix class
personal_identification(d.dist.m.query_reference, sample_individual) # Performing personal identification function

