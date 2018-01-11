// Create an account if there isn't one yet
if (web3.eth.accounts.length == 0) {
  personal.newAccount("");
}

// Unlock account
personal.unlockAccount(web3.eth.accounts[0], "");

var vote_contract = web3.eth.contract([{"constant":false,"inputs":[{"name":"x","type":"uint256"}],"name":"set","outputs":[],"payable":false,"type":"function","stateMutability":"nonpayable"},{"constant":true,"inputs":[],"name":"get","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function","stateMutability":"view"}]);

// deploy contract
var vote = vote_contract.new(
    {
      from: web3.eth.accounts[0],
      data: '0x6060604052341561000f57600080fd5b5b60ce8061001e6000396000f30060606040526000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff16806360fe47b11460475780636d4ce63c146067575b600080fd5b3415605157600080fd5b60656004808035906020019091905050608d565b005b3415607157600080fd5b60776098565b6040518082815260200191505060405180910390f35b806000819055505b50565b6000805490505b905600a165627a7a72305820bcfadd51e79a9302bebd44251b9deb2d9273c231e5c997ecabf67c1f7e8d7ef50029',
      gas: '100000'
    }, function (e, contract) {
      console.log(e, contract);
      if (typeof contract.address !== 'undefined') {
        console.log('Contract mined! address: ' + contract.address + ' transactionHash: ' + contract.transactionHash);
      }
    }
);
