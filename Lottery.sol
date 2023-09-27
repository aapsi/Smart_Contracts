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
        // the person who is participating, we need their addresss
        players.push(payable(msg.sender));
    }

    function getBalance() public view returns(uint){
        // only manager can check the balance
        require(manager == msg.sender, "You are not the manager");
    }

}