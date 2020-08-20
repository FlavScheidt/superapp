// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/SuperApp.sol";

contract TestSuperApp
{

	SuperApp _superApp = SuperApp(DeployedAddresses.SuperApp());

	bytes16 publicKey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC1D1EPT5P1+tTnnIj2X8NKeHHJnTA3c+3FkVhhEcgGsZeez/Kn2Ps7l4u3dmDGpr2NiR1PyHV/sfSWldNYJrAe+Do/tbRTJOUfaINh+kvozFEQHFULhNMfiYKr2y31zQpqe2K7mA1HxLFt23HbuyPCuG8Dsdsr9/IMzzd+UWeTzwIDAQAB";
	bytes32[32] encAddress = "https://sgxplay.westeurope.cloudapp.azure.com:4433";
	bytes16 encSignature = "2ab79217d77d1cdf10cb1b6234e6fa91a0d5f8564d8699828e77b49b3317f587";

	//Insert new member app
	function testNewMember() public
	{
		//Testing the add to the list
		address memberApp = _superApp.testNewMember(publicKey, encAddress, encSignature);
		//Is it succesfully inserted on thelist?
		Assert.equal(memberStatus.Active, _superApp.isMember(), "Member app add to the list");


		//Testing if the creation went ok
		MemberApp _memberApp = MemberApp(memberApp);
		Assert.equal(publicKey, _memberApp.getPublicKey(), "Public key is ok");
		Assert.equal(encAddress, _memberApp.getEncAddress(), "Enchave address is ok");
		Assert.equal(encSignature, _memberApp.getEncSignature(), "Enclave signature is ok");
		Assert.equal(address(this),_memberApp.getOwner(), "Owner is ok");
		Assert.equal(memberStatus.Active, _memberApp.getStatus(), "Status is ok");
		Assert.equal(address(_superApp), _memberApp.getSuperApp(), "Super app address is ok");


		//New users permission
		_memberApp.givePermission(0xD41A38e67f0eEA03D16B50b7554588fFaC36495D);
		Assert.equal(true, _memberApp.getPermission(address(this), 0xD41A38e67f0eEA03D16B50b7554588fFaC36495D), "Permission ok");

		//Revoke permission
		_memberApp.revokePermission(0xD41A38e67f0eEA03D16B50b7554588fFaC36495D);
		Assert.equal(false, _memberApp.getPermission(address(this), 0xD41A38e67f0eEA03D16B50b7554588fFaC36495D), "Permission revoked");

		//Delete Member
		_superApp.deleteMember(memberApp);
		Assert.equal(memberStatus.Inactive, _superApp.isMember(), "Member app removed from the list");
	}

}