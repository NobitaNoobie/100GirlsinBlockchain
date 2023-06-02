/*
NOTES:
--> The first thing that we are going to need is the version of that solidity
--> This version is going to be at the top of the code
--> Solidity is a constantly changing and updating language because it is relatively new
--> It shows a warning if the compiler version is not specified, and also suggests to include a given version
*/


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; // The warning will disappear now 


/*
NOTES:
--> A '^' symbol allows you to use a newer version of solidity
--> '^' == "Hey! any version of compiler 0.8.18 or above can be used."
--> If we want to use solidity version between specific version we use: pragma solidity >=0.8.7 <0.9.0;
*/

/*
--> 'contract' keyword is just like a 'class' in any OOP language
*/

contract SimpleStorage
{
    /*
    NOTES:
    --> Most basic types of types in Solidity are: boolean, uint, int, address, bytes
    --> boolean: true/false
    --> uint: 123 (unsigned), we can decide how many bits we can allocate [uint8 to uint256] by default it is 256 and gets initialize with zero
    --> address: paste from metamask wallet
    */
    uint256 public favoriteNumber; //default access specifier is 'internal'

    function store(uint256 _favoriteNumber) public 
    {
        favoriteNumber = _favoriteNumber;
    }

    /*
    NOTES:
    --> Everytime we deploy the 'store' function, we are doing some transactions, thus we can see 'hash' and 'from' 'to' 'gas' etc, as native to transactions
    --> We can increase the complexity of the transactions, which will cost more gas money
    --> See in the terminal that the 'transaction cost' increases with increase transaction complexity and the chain balance money decreases
    */


    /*
    NOTES- SCOPE:
    --> Just like Java, the scope of an internally declared variable is within that block only
    --> Use global variables
    */

    /*
    --> view and pure functions when called indivisually, they do not spend any gas. They are not transactions
    */

    /*
    NOTES:
    --> struct work like classes in Java
    --> you can declare a blueprint just like class and use it as a datatype thereon 
    */

    struct People
    {
        uint256 favNum;
        string name;
    }

    //People public person = People({favNum: 2, name: "Tiyasa"});

    People[] public peoplestack; //dynamic data structure of type 'People'
    /*
    --> 'peoplestack' now becomes a stack of type People
    */
    function addPerson(string memory _name, uint256 _favNum) public 
    {
        peoplestack.push(People(_favNum, _name));
    }
    /*
    the object was created in the push() for the above code
    we can also create an object of People type then push it in the peoplestack
    below is the alternative way
    */
    function addPerson1(string memory _name, uint256 _favNum) public 
    {
        People memory newperson = People({favNum: _favNum, name: _name});
        //People memory newperson = People(_favNum, _name);
        peoplestack.push(newperson);
    }
    
    
    /*
    --> calldata
    --> memory
    --> storage
    */

    /*
    NOTES:
    --> Demonstrate mapping in Solidity
    --> Syntax: mapping(type1 => type2) public map;
    */
    //let's map name to favorite number
    mapping(string => uint256) public map;
    function addPerson2(string memory _name, uint256 _favNum) public
    {
        map[_name] = _favNum;
        peoplestack.push(People(map[_name], _name));
    }
}
