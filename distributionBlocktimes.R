timestampsHomestead = as.matrix(read.csv(file = "blocktimes.csv"))
blocktimes= data.frame(day=as.Date(as.POSIXct(timestampsHomestead[-1,], origin="1970-01-01")), blocktime=diff(timestampsHomestead))
blocktimes= setNames(blocktimes, c("day","blocktime"))
summary(blocktimes$blocktime)
numberOfDays= length(unique(blocktimes$day));
hist(blocktimes$blocktime, breaks=numberOfDays*24, main = "Distribution of block times", xlab = "block time [s]", freq = FALSE)
plot(ecdf(blocktimes$blocktime),  main = "CDF of blocktimes", xlab = "block time [s]", ylab="cumulative density")
