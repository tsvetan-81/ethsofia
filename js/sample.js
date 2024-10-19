async function rewardMentor() {
  const accounts = await web3.eth.getAccounts();
  const mentorAddress = "MENTOR_WALLET_ADDRESS";
  const tokens = 100;
  const nftCV = "https://link-to-nft-cv-image.com";

  contract.methods
    .rewardMentor(mentorAddress, tokens, nftCV)
    .send({ from: accounts[0] })
    .on("receipt", function (receipt) {
      alert("Mentor rewarded with tokens and NFT on blockchain!");
    })
    .on("error", function (error) {
      console.error(error);
    });
}
