// SPDX-License-Identifier: UNLISCENCED
pragma solidity ^0.8.17;
// This contract is named Splitwise and provides a basic shared expenses tracking system.
// It defines a mapping 'debts' to keep track of the amounts that are owed between different users.
// The keys of the mapping are addresses of the debtors, and the values of the mapping are mappings of the creditors' addresses to the amounts owed.
// It defines a dynamic array 'users' to keep track of all the users that have participated in the expenses.
// 'public' modifier in the mapping declaration creates a public getter for the mapping.
contract Splitwise{
    mapping (address => mapping (address => int32 )) public debts;
    address[] public users;

    // This function named 'lookup' takes a debtor's address and a creditor's address and returns the amount of debt owed by the debtor to the creditor.
    // It is a view function and does not modify the state of the contract.
    function lookup (address debtor, address creditor) public view returns (int32 value) {
        value = debts[debtor][creditor];
    }

    // This function named 'add_IOU' allows a user to add a new debt to the mapping by specifying the creditor's address and the amount owed.
    // The function calls the 'addDebt' function with the sender's address as the debtor's address.
    function add_IOU (address creditor, int32 amount) public {
        addDebt(msg.sender, creditor, amount);
    }

    // This function named 'addDebt' adds a new debt to the mapping and calls 'addToUsers' to add the debtor's and creditor's addresses to the 'users' array.
    // It also checks that the amount of debt being added is positive.
    function addDebt (address debtor, address creditor, int32 amount) public {
        require(amount > 0, "Amount must be positive");
        debts[debtor][creditor] += amount;
        addToUsers(creditor);
        addToUsers(debtor);
    }

    // This function named 'addToUsers' adds a new address to the 'users' array if it is not already in the array.
    function addToUsers (address addy) private {
        for (uint i = 0; i < users.length; i++){
            if (users[i] == addy)
                return;
        }
        users.push(addy);
    }

    // This function named 'getUsers' returns the list of all users who have participated in the expenses.
    // It returns a dynamic array of all the addresses in the 'users' array.
    function getUsers() public view returns (address[] memory userArr) {
        userArr = new address[](users.length);

        for (uint i = 0; i < users.length; i++){
            userArr[i] = users[i];
        }
    }
}