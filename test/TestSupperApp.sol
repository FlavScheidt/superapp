// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <=0.7.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/SuperApp.sol";

contract TestSuperApp
{

	SuperApp _superApp = SuperApp(DeployedAddresses.SuperApp());

	string publicKey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC1D1EPT5P1+tTnnIj2X8NKeHHJnTA3c+3FkVhhEcgGsZeez/Kn2Ps7l4u3dmDGpr2NiR1PyHV/sfSWldNYJrAe+Do/tbRTJOUfaINh+kvozFEQHFULhNMfiYKr2y31zQpqe2K7mA1HxLFt23HbuyPCuG8Dsdsr9/IMzzd+UWeTzwIDAQAB";
	string encAddress = "https://sgxplay.westeurope.cloudapp.azure.com:4433";
	string encSignature = "2ab79217d77d1cdf10cb1b6234e6fa91a0d5f8564d8699828e77b49b3317f587";

	address memberApp;

	//Insert new member app
	function testNewMember() public
	{
		//Testing the add to the list
		memberApp = _superApp.newMember(publicKey, encAddress, encSignature);
		//Is it succesfully inserted on thelist?
		Assert.equal(uint(_superApp.isMember(memberApp)), uint(memberStatus.Active), "Member app add to the list");
	}

	function testQuerries() public
	{
		bytes16 result;
		string memory result_s;

		//Testing if the creation went ok
		MemberApp _memberApp = MemberApp(memberApp);

		result = _memberApp.getPublicKey();
		Assert.equal(_superApp.stringToBytes16(publicKey), result, "Public key is ok");

		result_s = _memberApp.getEncAddress();
		Assert.equal(encAddress, result_s, "Enchave address is ok");

		result = _memberApp.getEncSignature();
		Assert.equal(_superApp.stringToBytes16(encSignature), result, "Enclave signature is ok");

		Assert.equal(address(this),_memberApp.getOwner(), "Owner is ok");
		Assert.equal(uint(memberStatus.Active), uint(_memberApp.getStatus()), "Status is ok");
		Assert.equal(address(_superApp), _memberApp.getSuperApp(), "Super app address is ok");
	}

	function testPermissions() public
	{
		MemberApp _memberApp = MemberApp(memberApp);
		//New users permission
		_memberApp.givePermission(0xD41A38e67f0eEA03D16B50b7554588fFaC36495D);
		Assert.equal(true, _memberApp.getPermission(address(this), 0xD41A38e67f0eEA03D16B50b7554588fFaC36495D), "Permission ok");

		//Revoke permission
		_memberApp.revokePermission(0xD41A38e67f0eEA03D16B50b7554588fFaC36495D);
		Assert.equal(false, _memberApp.getPermission(address(this), 0xD41A38e67f0eEA03D16B50b7554588fFaC36495D), "Permission revoked");
	}

	function deleteMember() public
	{
		//Delete Member
		_superApp.deleteMember(memberApp);
		Assert.equal(uint(memberStatus.Inactive), uint(_superApp.isMember(memberApp)), "Member app removed from the list");
	}

}