pragma solidity ^0.4.19;
import "./ownable.sol";
import "./safemath.sol";
import "./rng.sol";

contract Pets is Ownable, Rng {
    
    using SafeMath for uint256;
    
    event NewPet
    (string _name, uint _hitPoints, uint _attack, uint _defence, uint _luck, uint level);

//    variables    
    uint hitPoints
    uint attack
    uint defence
    uint luck
    uint level
    string name
    
// pet struct
    struct Pet {
        string name;
        string title;
        uint hitPoints;
        uint vitality;
        uint attack;
        uint defence;
        uint dexterity;
        uint luck;
        uint rarity;
        uint level;
    }
    
    Monster[] private monsters;

    mapping (uint => address) public monsterToOwner;
    mapping (address => uint) public ownerMonsterCount;
    
    
    function makePet(string _input) public payable {
        require(msg.value == 0.01 ether);
        uint egg = trueSeed(_input);
        getSplice(egg);
    }
    
    // Takes values from _dnaSplicer and builds a monster.
    function _createMonster(string _name, uint _hitPoints, uint _attack, uint _defence, uint _dexterity, uint _luck) internal {
        uint id = monsters.push(Monster(_name, _hitPoints, _attack, _defence, _dexterity, _luck, 1)) - 1;
        monsterToOwner[id] = msg.sender;
        ownerMonsterCount[msg.sender].add(1);
        NewMonster(_name, _hitPoints, _attack, _defence, _luck, level);
    }
    
    // Takes the hash from getSplice and turns it into values.  
    function _dnaSplicer(uint seedone) private {
        uint something = uint(keccak256(seedone));
        uint[8] memory array;
        uint[8] memory random;
        for(uint i = 0; i < 8; i++) {
            uint digit = something % 10000;
            array[i] = digit;
            something /= 10000;
            random[i] = digit % 100;
            vitalityNumber = random[0];
            attackNumber = random[1];
            defenceNumber = random[2];
            dexterityNumber = random[3];
            luckNumber = random[4];
            nameNumber = random[5];
            titleNumber = random[6];
            rarityNumber = random[7];
        }
}
} 