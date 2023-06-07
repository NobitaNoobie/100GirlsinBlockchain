//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0

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
        uint voteCount;
    }
    
    address public chairPerson;
    mapping(address=>Voter) public votersMap;
    
    Proposal[] public proposals;
    
    constructor(bytes32[] memory proposalNames)
    {
        chairperson = msg.sender;
        votersMap[chairperson].weight = 1;
        
        for(uint i=0; i<proposalNames.length; i++)
        {
            proposals.push(Proposal({name: proposalNames[i], voteCount: 0}));
        }
    }
    
    //Authentication
    function giveRightToVote(address voter) external
    {
        require(msg.sender == chairperson, "Error: only chairperson can provide right to vote");
        require(votersMap[voter].voted == false, "Error: The voter has already voted");
        require(votersMap[voter].weight == 0); votersMap[voter].weight = 1;
    }
    
    //Delegation
    function delegate(address to) external
    {
        Voter storage sender = votersMap[msg.sender];
        require(sender.weight == 0, "Error: The sender is not an authenticated voter");
        require(sender.voted == true, "Error: The sender has already voted");
        require(to != msg.sender, "Error: Self-delegation is not allowed");
        
        while (voters[to].delegate != address(0)) 
        {
            to = voters[to].delegate;
            require(to != msg.sender, "Found loop in delegation.");
        }

        Voter storage delegate_ = voters[to];
        require(delegate_.weight >= 1);

        sender.voted = true;
        sender.delegate = to;

        if (delegate_.voted) 
        {
            proposals[delegate_.vote].voteCount += sender.weight;
        } 
        else 
        {
            delegate_.weight += sender.weight;
        }
    }
    
    //Voting process
    function vote(uint proposal) external
    {
        Voter storage sender = msg.sender;
        require(sender.weight == 0, "Error: Not authenticated to vote");
        require(sender.voted == false, "Error: Allowed to vote only once");
        
        sender.voted = true;
        sender.vote = proposal;
        
        proposals[proposal].voteCount += sender.weight;
    }
    
     /// @dev Computes the winning proposal taking all
    /// previous votes into account.
    function winningProposal() public view
            returns (uint winningProposal_)
    {
        uint winningVoteCount = 0;
        for (uint p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
    }

    // Calls winningProposal() function to get the index
    // of the winner contained in the proposals array and then
    // returns the name of the winner
    function winnerName() external view
            returns (bytes32 winnerName_)
    {
        winnerName_ = proposals[winningProposal()].name;
    }
}
