// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "./MemberApp.sol";

contract SuperApp
{
	/*************************
		List of member apps
	**************************/
	//We store only the address of the smart contract and map to its status
	mapping (address => memberStatus) private memberApps;

	/*************************
		Constructor
	**************************/
	// constructor ()
	// {
	// }

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
	function deleteMember (address memberApp) public
	{
		//The contract exists? Is it active?
		require(isMember(memberApp) == Active, "The contract does not exists or is inactive. Inactive contracts cannot be reactivate.");

		//Is the message sender the owner of the contract?
		//If in the future we need to give permission to a regulator to deactivate contracts, that shall be done HERE
		MemberApp _memberapp = MemberApp(memberApp);
		require(msg.sender == _memberapp.getOwner(), "You are not the owner of this member app. Only the owner can deactivate the member app");

		_memberapp.deactivate();

	}

	/*************************
		Verify membership
	**************************/
	function isMember (address memberApp) public returns (memberStatus)
	{
		return memberApps[memberApp];
	}

}