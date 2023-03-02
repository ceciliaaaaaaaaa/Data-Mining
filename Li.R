# Google Trends
rm(list=ls()); cat('\014')

GT.Data <- read.csv(
  paste0('Data/', 'geoMap.csv'), 
  stringsAsFactors = FALSE,
  skip = 2, 
  blank.lines.skip = TRUE, 
  header = T)

colnames(GT.Data) <- c('Region', 'GB', 'GG')
GT.Data[1:5,]

zGB <- as.numeric(GT.Data$GB) 
zGG <- as.numeric(GT.Data$GG) 

GT.Data$GB <- zGB
GT.Data$GG <- zGG

#1 
ix1 <- which(is.na(GT.Data$GB))
GT.Data$GB[ix1] <- 0
ix2 <- which(is.na(GT.Data$GG))
GT.Data[ix2,]
GT.Data$GG[ix2] <- 0
GT.Data$Region[which(GT.Data$GG == 0)]
#"South Dakota", "Maine", "Idaho", "Oregon" had a  GG is smaller than 1

#2 
sum (GT.Data$GB > GT.Data$GG)
# 45 States had a GB > GG

#3 
GT.Data$Region[which(GT.Data$GG + 10 > GT.Data$GB)]
#"Nevada", "Washington" had a GG+10 > GB

#4 
percentage<- sum(GT.Data$GG + 10 > GT.Data$GB) / nrow(GT.Data)
cat("There is", percentage*100, "%", "of states for which GG+10 > GB" )
# There is 4.347826 % of states for which GG+10 > GB

#5 
GT.Data$GG[GT.Data$Region == "New Hampshire"] / GT.Data$GB[GT.Data$Region == "New Hampshire"]
# The ratio of GG/GB for the state of New Hampshire is 0.5

#6 Create a Bar Plot of GG & GB values for each state
barplot(rbind(GT.Data$GG, GT.Data$GB), beside = TRUE, names.arg = GT.Data$Region, 
        ylab='Gift', main = "Bar Plot of GG&GB values", legend.text=c('GG','GB'), 
        las = 2, col = c("hotpink", "skyblue"))

