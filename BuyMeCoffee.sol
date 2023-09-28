
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Coffee {
    //  data structure to store the details
    struct Memo {
        string name;
        string message;
        uint256 timestamp;
        address from;
    }
    
    //  defining a struct type of array
    Memo[] public memos;  // Made public to allow easy access

    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function buyCoffee(string memory name, string memory message) public payable {
        require(msg.value > 0, "Please pay greater than 0 ether");
        owner.transfer(msg.value);
        // dynamic array so we are using push
        memos.push(Memo(name, message, block.timestamp, msg.sender));
    }

     //  getter function for memos
    function getMemos() public view returns(Memo[] memory) {
        return memos;
    }
}
