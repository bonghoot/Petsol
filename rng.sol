pragma solidity ^0.4.19;
import "./safemath.sol";
import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";

contract Rng is usingOraclize {
    
    using SafeMath for uint256;
    
    string public inputVal;
    string public toParse;
    uint public randNum;
    uint public randInput;
    uint public randBlock;
    uint public finalHash;
    
    event newOraclizeQuery(string description);
    event newNumber(string toParse);
    
    function display() view returns(uint){
        return randNum;
    }
    
// Lets oraclize callback result
    function __callback(bytes32 myid, string result) public {
        if (msg.sender != oraclize_cbAddress()) revert();
        toParse = result;
        newNumber(toParse);
        randNum = parseInt(result);
    }

// Grabs new randNum
    function seedOne() internal {
        newOraclizeQuery("Oraclize query was sent, standing by for the answer..");
        oraclize_query("WolframAlpha", "RandomInteger[99999]");
    }
    

// Takes input value and hashes for seed
    function trueSeed(string _input) internal returns (uint) {
        seedOne();
        randInput = uint(keccak256(inputVal, randNum, now, msg.sender, nonce));
        uint nonce = nonce.add(1);
        inputVal = _input;
    }

  
}