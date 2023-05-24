// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract SatelliteImageryIntegrity_dev {

    address public immutable minter;

    mapping (bytes => string) images;

    mapping (address => bool) admins;

    struct NewHash {
        string sceneId;
        string sceneHash;
    }

    constructor() {
        minter = msg.sender;
        admins[msg.sender] = true;
    }

    function writeHash(string memory sceneId, string memory sceneHash) public {
        require(admins[msg.sender]);

        bytes memory _bytesHash = bytes(sceneId);

        if (bytes(images[_bytesHash]).length != 0) return;
        
        images[_bytesHash] = sceneHash;
    }

    function checkHash(string memory sceneId) public view returns(string memory) {
        return images[bytes(sceneId)];
    }

    function writeHashArray(NewHash[] memory inputArray) public {
        for (uint i=0; i < inputArray.length; i++) {
            writeHash(inputArray[i].sceneId, inputArray[i].sceneHash);
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