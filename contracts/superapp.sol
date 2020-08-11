pragma solidity ^0.7.0;

/*************************
	 Global Structures
**************************/
enum memberStatus { Unset, Active, Inactive }
struct memberApp
{
	bytes16 publicKey;
	bytes32 [32] encAddress; //Bytes32 is more efficient and cheap than trings because they dont carry the UTF-8 enconding
	bytes16 enclaveSignature;
	address memberAppAddress;
	address memberAppOwner; //When creating a new member app, that's the caller address
}

contract superApp
{
	/*************************
		List of member apps
	**************************/
	//We store only the address of the smart contract and map to its status


	/*************************
		Structs and other variables
	**************************/	

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
	function newMember () public returns (address)
	{
		address owner = msg.sender;

	}

	/*************************
		Delete Member
	**************************/
	function deleteMember () public returns (bool)
	{

	}

	/*************************
		Verify membership
	**************************/
	function isMember () public returns (bool)
	{

	}

}