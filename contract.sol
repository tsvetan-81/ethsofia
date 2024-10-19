// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hackathon {
    struct Challenge {
        string title;
        string techStack;
        string description;
        address sponsor;
        address[] teamMembers;
        address mentor;
    }

    Challenge[] public challenges;
    mapping(address => uint256) public tokensEarned;
    mapping(address => string[]) public mentorNFTs;

    event ChallengeCreated(string title, string techStack, string description, address sponsor);
    event CollaborationSuccess(address mentor, address[] team, uint256 tokensRewarded, string nftCV);

    // Sponsor creates a challenge
    function createChallenge(string memory title, string memory techStack, string memory description, address[] memory teamMembers, address mentor) public {
        challenges.push(Challenge(title, techStack, description, msg.sender, teamMembers, mentor));
        emit ChallengeCreated(title, techStack, description, msg.sender);
    }

    // Reward mentor and team after successful collaboration
    function rewardMentorAndTeam(uint256 challengeIndex, uint256 tokensForMentor, uint256 tokensForTeam, string memory nftCV) public {
        require(challengeIndex < challenges.length, "Invalid challenge index");
        Challenge storage challenge = challenges[challengeIndex];
        
        // Distribute tokens to mentor
        tokensEarned[challenge.mentor] += tokensForMentor;
        mentorNFTs[challenge.mentor].push(nftCV);

        // Distribute tokens to each team member
        for (uint i = 0; i < challenge.teamMembers.length; i++) {
            tokensEarned[challenge.teamMembers[i]] += tokensForTeam;
        }

        emit CollaborationSuccess(challenge.mentor, challenge.teamMembers, tokensForMentor + (tokensForTeam * challenge.teamMembers.length), nftCV);
    }

    // Get the number of challenges
    function getChallengesCount() public view returns (uint256) {
        return challenges.length;
    }

    // Get total tokens earned by an address
    function getTokensEarned(address user) public view returns (uint256) {
        return tokensEarned[user];
    }
}
