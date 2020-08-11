// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

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
	//OBS.: necessary to add the storage location for the bytes32 array
	//Used memory, cause it is volatile and cheap
	constructor (bytes16 publicKey, bytes32[4] memory encAddress, bytes16 encSignature, address memberAppOwner)
	{
		_memberapp.publicKey 		= publicKey;
		_memberapp.encAddress 		= encAddress;
		_memberapp.encSignature 	= encSignature;
		_memberapp.memberAppOwner 	= memberAppOwner;
	}

	
}