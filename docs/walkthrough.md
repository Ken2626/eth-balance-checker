# Proof of Work: Gnosis Chain Compatibility

The `eth-balance-checker` project has been successfully refactored to fully support Gnosis Chain. You can now reliably monitor the native `XDAI` token as well as the `SDAI` and `GNO` tokens across various wallet addresses.

## Changes Made
1. **RPC Configuration**: 
   - [env.example](file:///home/znkan/test/eth-balance-checker/env.example) now accepts an `RPC_URL` instead of `INFURA_URL` to reflect its chain-agnostic design.
   - [main.py](file:///home/znkan/test/eth-balance-checker/main.py) prioritizes `RPC_URL` but still falls back to `INFURA_URL` if you migrate with an older [.env](file:///home/znkan/test/eth-balance-checker/.env) file.
2. **Native Token Support**:
   - Gnosis chain's native gas currency is `XDAI`. The code now explicitly watches for `XDAI` and routes that specific configuration element through the `eth_getBalance` JSON-RPC method, avoiding ERC20 contract mismatches.
3. **ERC-20 Token Contracts**:
   - Injected the correct ERC-20 contract configurations for `SDAI` and `GNO` onto the Gnosis chain directly into `pyetherbalance`.
   
## Next Steps
To run the project in Docker, execute:

```bash
# 1. Provide an RPC url and Telegram Bot configuration in a new .env file
cp env.example .env
nano .env 

# 2. Add wallets to your config
nano config.json

# 3. Build and Run via Docker
docker build -t eth-balance-checker .
docker run -d --name balance-bot --env-file .env -p 8000:8000 -v $(pwd)/config.json:/app/config.json eth-balance-checker
```
