// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract etherWallet{

    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {}

    function withdraw(uint _amount) external {
        require(msg.sender == owner, "caller is not owner");
        // owner.transfer(_amount);

        payable(msg.sender).transfer(_amount); //this approach saves gas
    }

    function getBalance() external view returns(uint){
        return address(this).balance;

    }

}

