timestampsHomestead = as.matrix(read.csv(file = "blocktimes.csv"))
blocktimes= data.frame(day=as.Date(as.POSIXct(timestampsHomestead[-1,], origin="1970-01-01")), blocktime=diff(timestampsHomestead))
blocktimes= setNames(blocktimes, c("day","blocktime"))
summary(blocktimes$blocktime)
quantile(blocktimes$blocktime, c(.9,.95,.99))
numberOfDays= length(unique(blocktimes$day));
dh=hist(blocktimes$blocktime, breaks=numberOfDays*24, main = "Distribution of block times", xlab = "block time [s]", freq = FALSE, col="blue")

abline(v=dh$breaks[10], col="grey", lty=2)
text(x=dh$breaks[10], y=dh$density[10]+.005, paste(dh$breaks[10],"s"))
#plot(ecdf(blocktimes$blocktime),  main = "CDF of blocktimes", xlab = "block time [s]", ylab="cumulative density")
