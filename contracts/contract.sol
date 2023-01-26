// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract SatelliteImageryIntegrity_dev {

    address public immutable minter;

    mapping (bytes => uint256) images;

    mapping (address => bool) admins;

    struct NewHash {
        string inputHash;
        uint256 timestamp;
    }

    constructor() {
        minter = msg.sender;
        admins[msg.sender] = true;
    }

    function writeHash(string memory inputHash, uint256 timestamp) public {
        require(admins[msg.sender]);

        bytes memory _bytesHash = bytes(inputHash);

        if (images[_bytesHash] != 0) return;
        
        images[_bytesHash] = timestamp;
    }

    function checkHash(string memory inputHash) public view returns(uint256) {
        return images[bytes(inputHash)];
    }

    function writeHashArray(NewHash[] memory inputArray) public {
        for (uint i=0; i < inputArray.length; i++) {
            writeHash(inputArray[i].inputHash, inputArray[i].timestamp);
        }
    }

    function checkAddressRights(address _address) public view returns(bool) {
        return admins[_address];
    }

    function manageAdminRights(address _address, bool permission) public {
        require(msg.sender == minter && _address != minter);
        admins[_address] = permission;
    }

}