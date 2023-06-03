// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Greeter {

    //Like functions, state variables can be declared with different levels of visibility modifiers, including public, internal, and private. 
    //Note that all data on blockchain is publicly visible from the outside world. 
    //State variable modifiers only restrict how the data can be interacted with from within the contract or other contracts.
    string private greeting = "Hello, World!";

    //The solidity language provides two types of addresses: one is address and the other is address payable. 
    //The difference between them is that address payable gives access to the transfer and send methods, and variables of this type can also receive ether. 
    //We are not sending ether to this address and we can use the address type for our purposes.
    address private _owner;

    constructor() {
        _owner = msg.sender;
    }

    // We need to update the function to be a view function since we are now going to access data stored on the blockchain.
    function greet() external view returns (string memory) {
        return greeting;
    }
    // The external modifier function can not be called from within the smart contract inwhich it is defined. We can call it from other contracts or transactions.
    // internal and private functions must use the implicit receiver, can not be called on an object or on this.
    //The major difference between these two modifiers is that private functions are only visible within the contract in which they are defined, and not in the derived contracts. 
    // Functions that will not alter the state of the contract’s variables can be marked as either pure or view. The pure function do not read data from the blockchain. 
    // Instead, they operate on the data passed in or, in the case, data that did not need any input at all e.g. return a string “hello world”. The view functions are allowed to read data from the blockchain, but again they are restricted in that they can not write to the blockchain. 
    // We can indicate that the returned value is not referencing anything located in our contract’s persisted storage by using the keyword memory. 
    
    // We want to add another function that allows us to set the message that will be returned by our greet() function.
    // Our setGreeting function is intended to update the state of our contract with a new greeting, which means we need to accept a parameter for this new value. 
    //because this function is being called from outside world, the data being passed in the parameter is not part of the contract's persisted storage, so it must be labelled with the data location calldata. The calldata location is only needed when the function is declared as external and when the data type of the parameter is a reference type such as a mapping, struct, or array. 
    
    // In order to update a variable in one function, and have that variable be available in another function, we will need to store the data in the contract's persisted storage by using state variable.

    function setGreeting(string calldata _greeting) external onlyOwner{
        greeting = _greeting;
    }

    // The modifier syntax looks very much similar like function syntax but without the visibility declaration. 
    // The first argument of require function is an expression that will evaluate to a boolean. When this expression results in false,
    //the transaction is completely reverted, meaning that all state changes are reversed and the program stops execution. 
    // second argument is optional. 
    // _; line is where the function that is being modified will be called. If you put anything after this line, it will be run after the function body completes. 
    modifier onlyOwner() {
        require(msg.sender == _owner, "Ownable: caller is not the owner");
        _;
    }

    //we want to set the owner of the greeter contract to the address that deployed the contract. 
    //This means we will need to store the address during initialization, and for that, we will need to write a constructor function. 
    //We will also need to access some information from the msg object which is globally available. 
    //To check that owner exist, we can invoke an owner getter function. Since this is a getter function, we need to add a state variable that will hold the address of the owner, and then our function should return that address.

    function owner() public view returns(address) {
        return _owner;
    }
}