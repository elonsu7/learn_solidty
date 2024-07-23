// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.24;
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";


contract NFTMarket_2 is IERC721Receiver{
    event List(address indexed seller,address indexed nftAddr,uint256 indexed tokenId,uint256 price);
    event Purchase(address indexed buyer,address indexed nftAddr, uint256 indexed tokenId,uint256 price);
    event Revoke(address indexed seller,address indexed nftAddr, uint256 indexed tokenId);
    event Update(address indexed seller,address indexed nftAddr,uint256 indexed tokenId,uint256 newPrice);

    struct Order { //订单
        address owner; //持有人
        uint256 price; //挂单价格
    }
    // 0 key NFT系列（合约地址) 1 key tokenId
    mapping (address => mapping (uint256 => Order)) public nftList;

    // NFT所有者才能进行操作
    modifier nftOwner(address _nftAddr, uint _tokenId) {
        Order storage _order = nftList[_nftAddr][_tokenId];
        require(_order.owner == msg.sender,"Not owner");
        _;
    }

    // NFT必须在合约中
    modifier hasNFT(address _nftAddr, uint _tokenId) {
        IERC721 _nft = IERC721(_nftAddr);
        require(_nft.ownerOf(_tokenId) == address(this),"Invalid Order"); //NFT在合约中
        _;
    }

    // msg.sender 挂单用户地址 address(this) 当前NFTMarket合约地址
    function list(address _nftAddr, uint _tokenId,uint _price) public {
        IERC721 _nft = IERC721(_nftAddr);
        require(_nft.getApproved(_tokenId) == address(this),"Need Approve");
        require(_price > 0, "price error");

        Order storage order = nftList[_nftAddr][_tokenId];
        order.owner = msg.sender;
        order.price = _price;

        _nft.safeTransferFrom(msg.sender, address(this), _tokenId);
        emit List(msg.sender,_nftAddr,_tokenId,_price);
    }

    function purchase(address _nftAddr, uint _tokenId) 
        public 
        payable 
        hasNFT(_nftAddr,_tokenId) 
    {
        Order storage _order = nftList[_nftAddr][_tokenId];
        require(_order.price > 0, "Invalid Price");
        require(msg.value >= _order.price,"Increase price"); //购买价格必须大于卖家出价

        IERC721 _nft = IERC721(_nftAddr);
        _nft.safeTransferFrom(address(this), msg.sender, _tokenId);
        // 将ETH转给卖家，多余ETH给买家退款
        payable(_order.owner).transfer(_order.price);
        payable(msg.sender).transfer(msg.value - _order.price);

        delete nftList[_nftAddr][_tokenId];
        emit Purchase(msg.sender,_nftAddr,_tokenId,_order.price);
    }

    function revoke(address _nftAddr, uint _tokenId)
        public 
        nftOwner(_nftAddr,_tokenId) 
        hasNFT(_nftAddr,_tokenId) 
    {
        IERC721 _nft = IERC721(_nftAddr);
        _nft.safeTransferFrom(address(this), msg.sender, _tokenId);
        delete nftList[_nftAddr][_tokenId];

        emit Revoke(msg.sender,_nftAddr,_tokenId);
    }

    function update(address _nftAddr, uint _tokenId,uint256 _newPrice)
        public 
        nftOwner(_nftAddr,_tokenId) 
        hasNFT(_nftAddr,_tokenId) 
    {
        Order storage _order = nftList[_nftAddr][_tokenId];
        _order.price = _newPrice;

        emit Update(msg.sender,_nftAddr,_tokenId,_newPrice);
    }

    // 实现{IERC721Receiver}的onERC721Received，能够接收ERC721代币
    function onERC721Received(
        address operator,
        address from,
        uint tokenId,
        bytes calldata data
    ) external override returns (bytes4) {
        return IERC721Receiver.onERC721Received.selector;
    }

    fallback() external payable{} 

    receive() external payable{}
}