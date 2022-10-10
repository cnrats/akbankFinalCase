const Grader = artifacts.require("Grader");

module.exports = async function (deployer) {
  await deployer.deploy(Grader);
};