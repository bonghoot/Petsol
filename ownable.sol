pragma solidity ^0.4.18;

contract Ownable {
    
//    address owner = YOUR ADDRESS HERE;
    address internal _owner = 0xca35b7d915458ef540ade6068dfe2f44e8fa733c
    ;
    
    function ownership(address newOwner) public onlyOwner {     // Add this constructor
        _owner = newOwner;
    }
    
        modifier onlyOwner {
        require(msg.sender == _owner);
        _;
    }
    
    function whoAmI() public returns(address){
        return msg.sender;
    }
    
    function whoIsOwner() public returns(address) {
        return _owner;
    }

    function renounceOwnership(string renounce) public onlyOwner returns(string) {
        if(keccak256(renounce) == keccak256('renounce')) {
            ownership(address(0));
            _owner = address(0);
            return("Ownership sucsessfully burned.");
        } else {
            return("If you want to renounce contract ownership (this will burn ownership, transfering contract to 0x0), you must input string 'renounce'.");
            revert();
        }
  }
}