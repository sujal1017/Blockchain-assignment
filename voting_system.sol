
 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

/*
    Project: Voting System
    Description: A blockchain-based voting system that allows
    users to vote for candidates and prevents duplicate voting.
*/

contract VotingSystem {

    // Structure to store candidate details
    struct Candidate {
        string name;     // Candidate name
        uint votes;      // Total votes received
    }

    // Array to store all candidates
    Candidate[] public candidates;

    // Mapping to track whether an address has voted
    mapping(address => bool) public hasVoted;

    // Constructor: Initializes candidates during deployment
    constructor() {
        candidates.push(Candidate("Alice", 0));
        candidates.push(Candidate("Bob", 0));
        candidates.push(Candidate("Charlie", 0));
    }

    /*
        Function: vote()
        Purpose: Allows a user to vote for a candidate.
        Prevents duplicate voting and invalid candidate selection.
    */
    function vote(uint candidateIndex) public {

        // Check whether the user has already voted
        require(!hasVoted[msg.sender], "Already voted");

        // Check whether the candidate index is valid
        require(candidateIndex < candidates.length, "Invalid candidate");

        // Increase the selected candidate's vote count
        candidates[candidateIndex].votes++;

        // Mark the user as having voted
        hasVoted[msg.sender] = true;
    }

    /*
        Function: getVotes()
        Purpose: Returns the total votes of a candidate.
        View function does not modify blockchain data.
    */
    function getVotes(uint index) public view returns (uint) {
        return candidates[index].votes;
    }

    /*
        Function: getWinner()
        Purpose: Finds and returns the candidate
        who received the highest number of votes.
    */
    function getWinner() public view returns (string memory) {

        uint winningVote = 0;
        uint winnerIndex = 0;

        // Compare the votes of all candidates
        for (uint i = 0; i < candidates.length; i++) {

            // Update winner if a candidate has more votes
            if (candidates[i].votes > winningVote) {
                winningVote = candidates[i].votes;
                winnerIndex = i;
            }
        }

        // Return the winning candidate's name
        return candidates[winnerIndex].name;
    }
}
