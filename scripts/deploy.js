async function main() {
    const TokenFactory = await ethers.getContractFactory("TokenFactory");
    const tokenFactory = await TokenFactory.deploy();
    await tokenFactory.waitForDeployment();
    console.log("TokenFactory deployed to:", tokenFactory.target);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
