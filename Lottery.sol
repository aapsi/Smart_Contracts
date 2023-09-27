// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract Lottery {
    // payable because they will receive funds
    address payable[] public players;
    address manager;
    address payable public winner;

    constructor() {
        // the person who will be deploying the smart contract is manager
        manager = msg.sender;
    }

    receive() external payable {
        // putting a check to make sure the participant has atleast 0.001 ether when they are applying
        require(msg.value == 0.001 ether, "Please pay 0.001 ether to participate");
        // the person who is participating, we need their addresss; we are pushing that into address object
        players.push(payable(msg.sender));
    }

    function getBalance() public view returns(uint){
        // only manager can check the balance
        require(manager == msg.sender, "You are not the manager");
        // this refers to the smart contract
        return address(this).balance;
    }

    // internal function only used within the smart contract
    // warning: this function should not be used while deploying on mainnet or in real world projects as this might not function correctly
    // this is used for demonstration purpose only
    function random() internal view returns(uint) {
        // this is the syntax to generate random numbers like this
        return uint(keccak256(abi.encodePacked(blockhash(block.number), block.timestamp, players.length)));
    }

    function pickWinner() public {
        // required checks
        require(msg.sender == manager, "You are not the manager");
        require(players.length >= 3, "Players are less than 3");

        uint r = random();
        uint index = r % players.length; // 100 % 3 = 1, 24 % 3 = 0
        // remainder < players.length
        winner = players[index];
        // transferring all the balance to the winner
        winner.transfer(getBalance());
        // now we will make the array empty for the game to start again
        players = new address payable[](0);
    }

    // using memory because we are talking about array here
    function allPlayers() public view returns(address payable[] memory) {
        return players;
    }

}