// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

// State variales: owner, balances
// Functions: purchase, restock, get balance
// constructor: set owner, set initial balance of vending machine


contract VendingMachine {
    // address to the deployer of the smart contract
    address public owner;
    mapping (address => uint) public donutBalances;

    constructor () {
        // msg.sender gives the address of the person who deployed the smart contract
        owner = msg.sender;
        // here this will give the address of the current smart contract
        donutBalances[address(this)] = 100;
    }

    function getVendingMachineBalance() public view returns (uint) {
        return donutBalances[address(this)];
    }

    function restock(uint amount) public {
        require(msg.sender == owner, "Only the owner can restock this machine");
        donutBalances[address(this)] += amount;
    }

    //  the transaction will e reverted if we dont have a the payable keyword
    function purchase(uint amount) public payable {
        require(msg.value >= amount * 0.001 ether, "You must pay atleast 0.001 ether per donut");
        require(donutBalances[address(this)] >= amount, "Not enough donuts in stock");
        donutBalances[address(this)] -= amount;
        donutBalances[msg.sender] += amount;
    }


}

