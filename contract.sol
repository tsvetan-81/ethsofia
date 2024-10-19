// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hackathon {
    struct Challenge {
        string title;
        string techStack;
        string description;
        address sponsor;
    }

    Challenge[] public challenges;
    mapping(address => uint256) public mentorTokens;
    mapping(address => string[]) public mentorNFTs;

    // Event for when a challenge is created
    event ChallengeCreated(string title, string techStack, string description, address sponsor);
    
    // Event for when a mentor receives tokens and an NFT
    event MentorRewarded(address mentor, uint256 tokens, string nftCV);

    // Sponsor creates a challenge
    function createChallenge(string memory title, string memory techStack, string memory description) public {
        challenges.push(Challenge(title, techStack, description, msg.sender));
        emit ChallengeCreated(title, techStack, description, msg.sender);
    }

    // Reward mentor with tokens and NFT
    function rewardMentor(address mentor, uint256 tokens, string memory nftCV) public {
        mentorTokens[mentor] += tokens;
        mentorNFTs[mentor].push(nftCV);
        emit MentorRewarded(mentor, tokens, nftCV);
    }

    // Get the number of challenges
    function getChallengesCount() public view returns (uint256) {
        return challenges.length;
    }
}
