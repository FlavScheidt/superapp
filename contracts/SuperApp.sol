// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "./MemberApp.sol";

contract SuperApp
{
	/*************************
		List of member apps
	**************************/
	//We store only the address of the smart contract and map to its status
	mapping (address => memberStatus) public memberApps;

	/*************************
		Structs and other variables
	**************************/

	/*************************
		Constructor
	**************************/
	constructor ()
	{

	}

	/*************************
		Register new Member
	**************************/
	//This function receives the information about a memberApp to be add
	//Creates a new smart contract and returns it`s address
	//The adress of the contract must be stored here, with its status
	function newMember (bytes16 publicKey, bytes32[4] memory encAddress, bytes16 encSignature) public returns (address)
	{
		address owner = msg.sender;
		MemberApp _memberapp = new MemberApp(publicKey, encAddress, encSignature, owner);

		//Get the address of the contract created
		address newContractAddress = address(_memberapp);
		//Insert address on the list
		memberApps[newContractAddress] = memberStatus.Active;

		return newContractAddress;
	}

	/*************************
		Delete Member
	**************************/
	// function deleteMember () public returns (bool)
	// {

	// }

	/*************************
		Verify membership
	**************************/
	// function isMember () public returns (bool)
	// {

	// }

}