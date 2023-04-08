// SPDX-License-Identifier: UNLICENSED

// DO NOT MODIFY BELOW THIS
pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract Splitwise {
// DO NOT MODIFY ABOVE THIS

// ADD YOUR CONTRACT CODE BELOW

    mapping(address => mapping (address => int32)) public debts;
    address[] public users;
    
    function lookup(address debtor, address creditor) public view returns (int32 ret){
        ret = debts[debtor][creditor];
    }
    function add_IOU(address creditor, int32 amount) public{
        addDebt(msg.sender, creditor, amount);
    }
    function addDebt(address debtor, address creditor , int32 amount) private {
        require(amount > 0);
        debts[debtor][creditor] += amount;
        addToUsers(creditor);
        addToUsers(debtor);
    }
    function addToUsers(address add) private{
        for (uint i = 0; i < users.length; i++){
        if (users[i] == add)
            return;
        }
        users.push(add);
    }
    
    function getUsers() public view returns (address[] memory ret){
        ret = new address[](users.length);
        for (uint i = 0; i < users.length; i++){
            ret[i] = users[i];
        }
    }
      
}
