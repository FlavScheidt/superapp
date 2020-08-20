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
	// address memberAppAddress;
	address memberAppOwner; //When creating a new member app, that's the caller address
	memberStatus status;
	address superAppAddress; //Superapp this member belongs to
}

contract MemberApp
{
	memberApp private _memberapp;

	//Thats the lost of users permissions
	//Please read the Permissions section above
	//Basically we map the address of an user to the address of an app and use a bool to set or unset the permissions
	mapping (address => mapping (address => bool)) usersPermissions;

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
		_memberapp.memberStatus		= Active;
		_memberapp.superAppAddress	= msg.sender;
	}

	/*************************
	 Getters
	**************************/
	function getPublicKey() public returns(bytes16)
	{
		return _memberapp.publicKey;
	}

	function getEncAddress() pubic returns(bytes16[32])
	{
		return _memberapp.encAddress;
	}

	function getEncSignature() public returns(bytes16)
	{
		return _memberapp.encSignature;
	}

	function getOwner() public returns(address)
	{
		return _memberapp.memberAppOwner;
	}

	function getStatus() public returns(memberStatus)
	{
		return status;
	}

	function getSuperApp() public returns(address)
	{
		return superAppAddress;
	}

	/*************************
	 Setters
	**************************/
	function deactivate() public
	{
		//Only the superapp have power to deactivate the member app
		require(msg.sender == getSuperApp(), "Call the super app to deactivate this member app. If you are not the owner of this app you will not be able to do so");
		_memberapp.status = Inactive;
	}

	/*************************
	 Permissioning
	**************************/
	//Ugliest way to do so, but also the fast right now
	//Thats actually a big to do in this context, cause we need to think on a more effiecient way to do it
	//Here we are storing all the permissions every user gave to OTHER member apps to access data
	//It will get inefficient when put on production
	function givePermission(address app) public 
	{
		usersPermissions[msg.sender][app] = 1;
	}

	function revokePermission(address app) public
	{
		usersPermissions[msg.sender][app] = 0;
	}

	function getPermission(address user, address app) public returns (bool)
	{
		return usersPermissions[user][app];
	}
	
}