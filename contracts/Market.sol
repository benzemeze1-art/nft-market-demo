// contracts/Market.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC721 { function transferFrom(address, address, uint256) external; }

contract Market {
    struct Listing { address nft; uint256 id; uint256 price; address seller; }
    Listing[] public listings;

    function list(address nft, uint256 id, uint256 price) external {
        listings.push(Listing(nft, id, price, msg.sender));
    }

    function buy(uint256 i) external payable {
        Listing storage l = listings[i];
        require(msg.value == l.price);
        IERC721(l.nft).transferFrom(l.seller, msg.sender, l.id);
        payable(l.seller).transfer(msg.value);
    }
}
