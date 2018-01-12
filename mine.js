// Create an account if there isn't one yet
if (web3.eth.accounts.length == 0) {
  personal.newAccount("");
}

if (web3.eth.getBlock("pending").transactions.length > 0) {
  if (!web3.eth.mining) {
    console.log("Incoming pending transactions ... mining ...");
    miner.start(1);
  }
} else {
  console.log("Finished pending transactions ... stop mining ...");
  miner.stop();
}
