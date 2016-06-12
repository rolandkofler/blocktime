timestampsHomestead = as.matrix(read.csv(file = "blocktimes.csv"))
blocktimes= data.frame(day=as.Date(as.POSIXct(timestampsHomestead[-1,], origin="1970-01-01")), blocktime=diff(timestampsHomestead))
blocktimes= setNames(blocktimes, c("day","blocktime"))
summary(blocktimes$blocktime)
quantile(blocktimes$blocktime, c(.9,.95,.99))
numberOfDays= length(unique(blocktimes$day));
dh=hist(blocktimes$blocktime, breaks=numberOfDays*24, main = "Distribution of block times", xlab = "block time [s]", freq = FALSE, col="blue")
x <- seq(0, 150, 1)
axis(side=1, at=seq(0,160, 5), labels=seq(0,160,5))
maximumCount=max(dh$counts, na.rm = TRUE)
maxIndex=which(dh$counts==maximumCount)
abline(v=dh$breaks[maxIndex], col="grey", lty=2)
text(x=dh$breaks[maxIndex], y=dh$density[maxIndex]+.01, paste(dh$breaks[maxIndex],"s"))
#plot(ecdf(blocktimes$blocktime),  main = "CDF of blocktimes", xlab = "block time [s]", ylab="cumulative density")
abline(v=dh$breaks[maxIndex], col="grey", lty=2)
text(x=dh$breaks[maxIndex], y=dh$density[maxIndex]+.01, paste(dh$breaks[maxIndex],"s"))

#' Montecarlo confirmation simulator

calculateBlocktime = function(nConf=nConfirmations, blockt=blocktimes) {
  times= sample(x=blockt$blocktime, size=nConf)
  bt=sum(times)
  return (bt)  
}

require(ggplot2)
require(reshape2)
N=10000
nConfirmations= 3
conf50=replicate(N, calculateBlocktime(nConfirmations, blocktimes))
confirmationTimes=data.frame(n.1=replicate(N, calculateBlocktime(nConf = 1, blocktimes)), 
                             n.2= replicate(N, calculateBlocktime(nConf = 2, blocktimes)), 
                             n.3= replicate(N, calculateBlocktime(nConf = 3, blocktimes)), 
                             n.5= replicate(N, calculateBlocktime(nConf = 5, blocktimes)),
                             n.8= replicate(N, calculateBlocktime(nConf = 8, blocktimes)), 
                             n.13= replicate(N, calculateBlocktime(nConf = 13, blocktimes)),
                             n.21= replicate(N, calculateBlocktime(nConf = 21, blocktimes)),
                             n.35= replicate(N, calculateBlocktime(nConf = 35, blocktimes)),
                             n.55= replicate(N, calculateBlocktime(nConf = 55, blocktimes))
                             )
#hist(conf50,  breaks=numberOfDays, main = paste("Simulated Distribution of ",nConfirmations," Confirmations"), xlab = "confirmation time [s]", freq = T, col="blue")
# qplot(blocktimes$blocktime, geom = "histogram", breaks = seq(0, 180, 1), colour = I("black"), fill = I("white"), xlab = "block time [s]", ylab = "Count")+
library(reshape2)
data<- melt(confirmationTimes)
ggplot(data,aes(x=value, fill=variable)) + geom_density(alpha=0.25) +  xlab( "confirmation time [s]") + ggtitle("Expected time per n confirmations");
ggplot(data,aes(x=variable, y=value, fill=variable)) + geom_boxplot()+  xlab( "wait ing for n confirmations") +  xlab( "confirmation time [s]")+ ggtitle("Quartiles and outliers for n confirmations");

