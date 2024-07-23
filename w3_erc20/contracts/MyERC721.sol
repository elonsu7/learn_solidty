// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "./Counters.sol";

contract MYERC721 is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    constructor() ERC721(unicode"西游记妖精谱","West Fairy"){}

    function mint(address fairy, string memory fairyURI) public returns(uint256){
        uint256 newItemId = _tokenIds.current();
        _mint(fairy,newItemId);
        _setTokenURI(newItemId,fairyURI);

        _tokenIds.increment();
        return newItemId;
    }
}