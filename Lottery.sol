// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract Lottery {
    // payable because they will receive funds
    address payable[] public players;
    address manager;
    address payable public winner;

    constructor() {
        // the person who will be deploying the smart contract is the manager
        manager = msg.sender;
    }
        
    function getBalance() public view returns(uint) {
        require(manager == msg.sender, "You are not the manager");
        return address(this).balance;
    }

    function random() internal view returns(uint) {
        uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));
    }

    function pickWinner() view public {
        require(msg.sender == manager, "You are not the manager");
        require(players.length >= 3, "Players are less than 3");

        uint r = random();
        uint index = r % players.length;

    }
}