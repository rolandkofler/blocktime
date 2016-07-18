Blocktime - Investigating Ethereum Blocktime with R
===

This project analyses different aspects of the time it takes to mine a new block.

###    Analysis
##### Motivation
What people currently know is the average block time. The monitoring sites [ethstats.net](ethstats.net) and [etherscan.io](https://etherscan.io/charts/blocktime) provide a good overview in realtime for this metric. 
Before Ethereum will be upgraded to Proof of Stake, the time to mine a block, the average block time is ~14 s. But block times over a minute are not uncommon.
For certain applications, precise knowledge of the variance of the block times is vital, for example realtime gambling applications where a user must wait for a result in a smart contract.
##### Methodology
The difference of two Block timestamps is made and this difference is analysed.  First the quantiles are calculated to have a first glance of the distribution, then the 
##### Description of the data and the sourcing of the data
[Blocktimes.csv](blocktimes.csv) contains a dataset of collected between the *Ethereum Homestead* release and 10 June 2016. Each row represents the Posix Date of the block mined since the first *Homestead* block (13000).  
You can collect your own data with the [collectBlockTimes.js](collectBlockTimes.js) script.

    geth --exec 'loadScript("./collectBlockTimes.js")' attach http://localhost:8545




##### Results
Figure: the distribution of observe block times and their density. Peak block time is around 2.9 s, median 10 s and average 14 s, maximum observed 2 min 54 s. Source on Github.
The quartiles are:

   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   1.00    5.00   10.00   14.35   19.00  174.00

In laymen’s terms: 
block time is at least 1s, because seconds is the granularity of the timestamp
25% of all transactions are ⩽5s
Median gives you an average that does factor out the outliers (174s)
Mean gives you an average that includes outliers
75% of all transactions are ⩽19s
The biggest Outlier 174s measured since Homestead (16 March - 11 June 2016). 


Waiting for confirmations
Blockchains solve the double spending attack vector by concatenation of multiple confirmations of randomly selected mining nodes. Having one confirmation means trusting the current miner. For smaller amounts this might be a good idea. 
How can we relate the transaction amount and the confirmation times?
In an article Buterin lays out 2 potential attack vectors: 
Byzantine fault tolerance model: a certain percentage of all miners are attackers, and the rest are honest altruistic people.
Economic model: there is an attacker with a budget of $X which the attacker can spend to either purchase their own hardware or bribe other users, who are rational.

Amounts under minimal mining rewards of 5 ETH
Here we can safely accept 1 confirmation, which is mined in about 1 min.
 
Fig: A 99% sure confirmation is reached after ~61 s (~ 1 min)
Amounts over 5 ETH
 [...] the 17-second blockchain will likely require ten confirmations (~three minutes) to achieve a similar degree of security under this probabilistic model to six confirmations (~one hour) on the ten-minute blockchain. -- Vitalik Buterin on “the Normal Attack”




