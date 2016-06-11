// geth --exec 'loadScript("./collectBlockTimes.js")' attach http://localhost:8545

var times =[];
var homestead= 13000;

for (i = homestead; i < eth.blockNumber; i++) {
  var blk = web3.eth.getBlock(i)
  console.log(blk.timestamp);
}
