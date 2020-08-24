// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <=0.7.0;

import "./MemberApp.sol";

contract SuperApp
{
	/*************************
		List of member apps
	**************************/
	//We store only the address of the smart contract and map to its status
	mapping (address => memberStatus) private memberApps;
	address[] internal memberAddress;
	uint nMembers;

	/*************************
		Constructor
	**************************/
	constructor () public
	{
		nMembers = 0;
	}

	/*************************
		Convert strings to bytes
	**************************/
	//I didnt write this. Source is https://ethereum.stackexchange.com/a/9152/63251
	//Just adapted to bytes16
	function stringToBytes16(string memory source) public pure returns (bytes16 result) 
	{
	    bytes memory tempEmptyStringTest = bytes(source);
	    if (tempEmptyStringTest.length == 0) {
	        return 0x0;
	    }

	    assembly {
	        result := mload(add(source, 16))
	    }
	}

	/*************************
		Register new Member
	**************************/
	//This function receives the information about a memberApp to be add
	//Creates a new smart contract and returns it`s address
	//The adress of the contract must be stored here, with its status
	function newMember (string memory publicKey, string memory encAddress, string memory encSignature) public returns (address)
	{
		address owner = msg.sender;
		MemberApp _memberapp = new MemberApp(stringToBytes16(publicKey), encAddress, stringToBytes16(encSignature), owner);

		//Get the address of the contract created
		address newContractAddress = address(_memberapp);
		//Insert address on the list
		memberApps[newContractAddress] = memberStatus.Active;

		memberAddress.push();
		nMembers++;

		return newContractAddress;
	}


	/*************************
		Delete Member
	**************************/
	function deleteMember (address memberApp) public
	{
		//The contract exists? Is it active?
		require(isMember(memberApp) == memberStatus.Active, "The contract does not exists or is inactive. Inactive contracts cannot be reactivate.");

		//Is the message sender the owner of the contract?
		//If in the future we need to give permission to a regulator to deactivate contracts, that shall be done HERE
		MemberApp _memberapp = MemberApp(memberApp);
		require(msg.sender == _memberapp.getOwner(), "You are not the owner of this member app. Only the owner can deactivate the member app");

		_memberapp.deactivate();

	}

	/*************************
		Verify membership
	**************************/
	function isMember (address memberApp) public view returns (memberStatus)
	{
		return memberApps[memberApp];
	}

	/*************************
		Return list of memberapps
	**************************/
	function listMembers() public view returns (address[] memory)
	{
		return memberAddress;
	}

	/*************************
		Return list of active memberapps
	**************************/
	//Dirty and ugly solution, but it works 
	function listActiveMembers() public view returns (address[] memory)
	{
		address[] memory activeMembers;
		uint y=0;
		for (uint i=0; i<nMembers; i++)
		{
			if (isMember(memberAddress[i]) == memberStatus.Active)
			{
				activeMembers[y]=memberAddress[i];
				y++;
			}

		}

		return activeMembers;
	}

}