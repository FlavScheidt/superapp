pragma solidity ^0.6.4;

/*************************
	 Global Structs
**************************/
struct memberApp
{
	bytes16 publicKey;
	bytes32 [32] encAddress; //Bytes32 is more efficient and cheap than trings because they dont carry the UTF-8 enconding
	bytes16 enclaveSignature;
	address memberAppAddress;
	bool status;
}


contract superApp
{
	//List of member apps
	


	/*************************
		Constructor
	**************************/
	function superApp() public
	{

	}

	/*************************
		Register new Member
	**************************/
	//This function receives the information about a memberApp to be add
	//Creates a new smart contract and returns it`s address
	//The adress of the contract must be stored here, with its status
	function NewMember () public returns (address)
	{

	}

	/*************************
		Delete Member
	**************************/

}