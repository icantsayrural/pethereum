if (web3.eth.getBlock("pending").transactions.length > 0) {
  if (web3.eth.mining) {
    return;
  }

  console.log("Incoming pending transactions ... mining ...");
  miner.start(1);
} else {
  console.log("Finished pending transactions ... stop mining ...");
  miner.stop();
}
