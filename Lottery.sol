// SPDX-License-Identifier: GPL-3.0
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
}