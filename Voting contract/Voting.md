
```solidity
//PDX-license identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0
```
- The contract starts with a SPDX License Identifier indicating the license under which the code is released.
- The contract uses the Solidity version pragma pragma solidity >=0.7.0 <0.9.0; to specify the version of Solidity being used. The range of the versions permitted for the code is suggested by the use of the inequality and equality symbols while specifying the version
---
## concept: ```struct```

- struct (short for structure) is a user-defined data type that allows you to group together related variables of different types into a single unit. It provides a way to create a custom data structure with its own set of properties and behaviors.Structs are useful when you want to organize and manage data that belongs together, similar to a record or a data structure in other programming languages.
---
```solidity
contract Ballot
{
    struct Voter
    {
        uint weight;
        bool voted;
        address delegate;
        uint vote;
    }
    
    struct Proposal
    {
        bytes32 name;
        uint votesCount;
    }

```
- In any voting system the basic structures are: *atleat one proposal* and *atleat one voter*
- The contract named `Ballot` begins with defining reusable blueprints of these fundamental elements
- To define a *reusable blueprint* in Solidity, we define a `struct`
- It is assumed that *delegation is allowed*. In real world,delegation allows voters to transfer their voting rights to another person who will vote on their behalf.
1. ```Voter```
    - `weight` : If the `weight == 1`, it implies that the value carried by the vote cast by this particular voter is `1`. If someone else asks this voter to vote on their behaf(delegation), the value of the vote cast by this voter will be `2`, and so on. (How many votes is his one cast equal to + If he is casting additonal votes on delegation). If `1` their vote is counted as a single vote, etc.
    - `voted` : As the voting progresses, each person keeps track of whether they have already cast their vote or not using a checkbox. If they have cast their vote, the checkbox is marked as checked. This field is denoted by `true`\ `false`.
    - `delegate` : This field stores the address of the person to whom the voter has delegated their voting power.
    - `vote` : In a voting system, proposals are usually numbered or assigned an index, and voters select the proposal they want to vote for by specifying the corresponding index. It is equivalent to choosing a `uint`th proposal to cast a vote.

2. ```Proposal```
    - `name` : Each proposal is assigned a unique identifier (such as a name) to distinguish it from others. 
    - `voteCount` : As people vote for their preferred proposals, the vote count for each proposal is accumulated. The proposal with the highest vote count may eventually be declared the winner.

---
## concept: `msg.sender`
- When the contract is initially deployed, the address of the deploying account is stored in msg.sender. This address is typically assigned to a state variable within the contract if it needs to be referenced later.
- Example:
```solidity
pragma solidity ^0.8.0;

contract MyContract {
    address public owner;

    constructor() {
        owner = msg.sender;
    }
}
```
- By default, the first person who deploys this contract will have their address stored in the `owner` public variable. This information can be used for access control, ownership verification, or any other logic within the contract that requires the deployer's address.
---

```solidity
address public chairperson;

mapping(address => Voter) public votersMap;
Proposal[] public proposals;
```
- There must be a chairperson to oversee the voting process.
- This line assigns `msg.sender` (the address of the person deploting the contract) to the `chairperson` variable. It identifies the initial chairperson who deploys the contract.
- This address is necessarry later so it is stored.

- The mapping called `votersMap` associates each address to a `Voter` struct object. 
- It has a key-value pair and can be imagined as a sign-up sheet where the voter in real-world needs to fill it with his Voter's id and all his information(as suggested in the blueprint) will be linked to that Voter's id
- Now this Voter's id key references a `struct` representing a person.

- A dynamic array of the type `Proposals` is also decared
- It can be linked to a real-world ballot where a person needs to fill in `proposalName` and number of votes and submit his proposal for voting.

---
## concept: `memory`
- memory can be imagined as a slate you are using for doing some work.
- you use that clean slate to jot down some thoughts to aid the progress of your work.
- once your work is done you can wipe down that slate to accomodate new thoughts for a separate job.
- **In Solidity,*we use the memory keyword to store the data temporarily during the execution of a smart contract. When a variable is declared using the `memory` keyword, it is stored in the memory area of the EVM (Ethereum Virtual Machine).***
- This is the default storage location for variables in Solidity.
---

```solidity
constructor(bytes32[] memory proposalNames)
{
    chairperson = msg.sender;
    votersMap[chairperson].weight = 1;
    for(uint i=0; i<proposalNames.length; i++)
    {
        proposals.push(Proposal({name: proposalNames[i], voteCount: 0}));
    }
}
```
- The value of the vote of the `chairperson` is `1`= `weight`. This means their vote counts as a single vote.
- The address of the deployer = the address of the chairperson, is used to reference the weight and update it, using the map. 
- We iterate through the given proposal name list and create a `Proposal` type object and push it to the dynamic array `proposals`.
---

## concept: `require()`
- It operates in the manner that if the condition within the parenthesis is true, the compiler will execute the piece of code written beneath it. This is the first and compulsory argument passed to `require`.
- As a second argument, you can also provide an explanation about what went wrong, enclosed within "".

## concept: `external` keyword
- These functions can be *called only outside the contract by other contracts*.
- `this.function_name()` if we want to call such functions within the contract we use `this` keyword.
- `external` uses less gas than `public`, because `public` copies the passed arguments to memory while `external` reads it directly from calldata, which is cheaper. The reason `public` uses memory is because the allow internal calling. 
---
## Authentication
```solidity
function giveRightToVote(address voter)
{
    require(msg.sender == chairperson, "Only chairperson can give access to voting rights");
    //the person deploying(msg,sender) should be the address stored in the chairperson variable
    
    require(votersMap[voter].voted == false, "This person must be allowed to vote only once");
    
    require(votersMap[voter].weight == 0);
    votersMap[voter].weight = 1;
}
```
- This section is used to validate a `voter`. 
- The second `require` statement checks if the `voter` has voted, if `true` the execution terminates with the error message in the "".
---



*Copyright: Tiyasa Khan*
