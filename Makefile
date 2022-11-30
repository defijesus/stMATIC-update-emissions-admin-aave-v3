# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

# deps
update:; forge update

# Build & test
build  :; forge build --sizes
test   :; forge test -vvv

deploy-payload :; forge script scripts/DeployChangeEmissionAdmin.s.sol:DeployChangeEmissionAdmin --rpc-url ${RPC_POLYGON} --broadcast --ledger --sender ${LEDGER_SENDER} --verify --chain 137 --etherscan-api-key ${POLYGONSCAN_API_KEY} -vvvv

submit-proposal :; forge script scripts/DeployL1PolygonProposal.s.sol:DeployChange --rpc-url ${RPC_ETHEREUM} --broadcast --private-key ${PRIVATE_KEY} -vvvv