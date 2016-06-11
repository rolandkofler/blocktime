timestampsHomestead = as.matrix(read.csv(file = "blocktimes.csv"))
blocktimes= data.frame(day=as.Date(as.POSIXct(timestampsHomestead[-1,], origin="1970-01-01")), blocktime=diff(timestampsHomestead))
blocktimes= setNames(blocktimes, c("day","blocktime"))
summary(blocktimes$blocktime)
quantile(blocktimes$blocktime, c(.9,.95,.99))
numberOfDays= length(unique(blocktimes$day));
dh=hist(blocktimes$blocktime, breaks=numberOfDays*24, main = "Distribution of block times", xlab = "block time [s]", freq = FALSE, col="blue")
maximumCount=max(dh$counts, na.rm = TRUE)
maxIndex=which(dh$counts==maximumCount)
abline(v=dh$breaks[maxIndex], col="grey", lty=2)
text(x=dh$breaks[maxIndex], y=dh$density[maxIndex]+.005, paste(dh$breaks[maxIndex],"s"))
#plot(ecdf(blocktimes$blocktime),  main = "CDF of blocktimes", xlab = "block time [s]", ylab="cumulative density")

