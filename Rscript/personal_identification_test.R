###################################################################
## created by Hikaru Watanabe at Tokyo Institute of Technology   ##
## 2017-11-24                                                    ##
## email<watanabe.h.ap@m.titech.ac.jp>                           ##
## R version 3.3.2 (2016-10-31)                                  ##
###################################################################

# setting directory
setwd("human_skin_personal_identification")

# function of leave one out method (removing same sample with query from reference samples)
personal_identification <- function(d.dist.m.query_reference, sample_individual){
  query     <- rownames(d.dist.m.query_reference)
  reference <- colnames(d.dist.m.query_reference)

  rownames(sample_individual) <- as.vector(sample_individual$sample)
  df_query     <- sample_individual[query    ,]
  df_reference <- sample_individual[reference,]
  
  # calcurating the score of individual classification
  # list up the learning_data
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
    
    df_reference_temp   <- subset(df_reference, sample!=q)
    using_reference     <- as.vector(df_reference_temp$sample)
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

# Demonstration of performing to personal_identification.
data   <- read.table("matrix/test_data.otu", sep="\t",header=T,row.names=1) #reading OTU table
sample_individual <- read.table("matrix/test_data.list", sep="\t",header=T) #reading sample and individual table
d.rate <- prop.table(as.matrix(data),2) #calcurating relative abundance of OTU
d.dist                   <- dist(t(d.rate), method="canberra") # calcurating distance
d.dist.m.query_reference <- as.matrix(d.dist) # convert to matrix class
personal_identification(d.dist.m.query_reference, sample_individual) # performing personal_identification methods

# if you want to select reference and query.
data   <- read.table("matrix/test_data.otu", sep="\t",header=T,row.names=1) #reading OTU table
sample_individual <- read.table("matrix/test_data.list", sep="\t",header=T) #reading sample and individual table
d.rate <- prop.table(as.matrix(data),2) #calcurating relative abundance of OTU
d.dist                   <- dist(t(d.rate), method="canberra") # calcurating distance
d.dist.m.query_reference <- as.matrix(d.dist) # convert to matrix class
query     <- c("A1", "B1", "C1") # selection of query samples
reference <- c("A2", "A3", "B2", "B3", "C2", "C3") # selection of reference samples
d.dist.m.query_reference2 <- d.dist.m.query_reference[query, reference] # making distance matrix of query and reference samples 
personal_identification(d.dist.m.query_reference2, sample_individual) # performing personal_identification methods

##########################################################################################
##  From here, we demonstrate personal identification to our original data              ## 
## 'Environmental bacteria contribute personal identification of human skin microbiome' ##
##########################################################################################
data   <- read.table("matrix/skin_16S_ourdata.otutable",
                    sep="\t",header=T,row.names=1)
d.rate <- prop.table(as.matrix(data),2)

# making list of sample and individual
sample_individual <- read.table("matrix/skin_16S_ourdata.list",
                                sep="\t",header=T)

# calcurating to distance between all samples
d.dist                   <- dist(t(d.rate), method="canberra")
d.dist.m.query_reference <- as.matrix(d.dist)

# Making sample and inddividaul table
personal_identification(d.dist.m.query_reference, sample_individual)

# Query is 1st year's samples, reference is 2nd year's samples.
data.1st.2nd <- d.dist.m.query_reference[c(1:3,  7:9 , 13:15, 19:21, 25:27, 31:33, 37:39, 43:45, 49:51, 55:57, 61:63),
                                         c(4:6, 10:12, 16:18, 22:24, 28:30, 34:36, 40:42, 46:48, 52:54, 58:60, 64:66)]
personal_identification(data.1st.2nd, sample_individual)

# Query is 2nd year's samples, reference is 1st year's samples.
data.2nd.1st <- d.dist.m.query_reference[c(4:6, 10:12, 16:18, 22:24, 28:30, 34:36, 40:42, 46:48, 52:54, 58:60, 64:66),
                                         c(1:3,  7:9 , 13:15, 19:21, 25:27, 31:33, 37:39, 43:45, 49:51, 55:57, 61:63)]
personal_identification(data.2nd.1st, sample_individual)
