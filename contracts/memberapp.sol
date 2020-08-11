pragma solidity ^0.6.4;

/*************************
 Global
**************************/
enum memberStatus { NotSet, Active, Inactive }
struct memberApp
{
	bytes16 publicKey;
	bytes32 [32] encAddress; //Bytes32 is more efficient and cheap than trings because they dont carry the UTF-8 enconding
	bytes16 encSignature;
	address memberAppAddress;
	address memberAppOwner; //When creating a new member app, that's the caller address
}

contract MemberApp
{
	memberApp _memberapp;

	/*************************
	 Constructor
	**************************/
	function memberApp(bytes16 publicKey, bytes32[] encAddress, bytes16 encSignature, address memberAppOwner) public
	{

	}

	
}