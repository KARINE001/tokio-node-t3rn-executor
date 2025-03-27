# Supported Networks – t3rn

You can specify the network to connect to using the `--network` flag.

Example:
```bash
./executor --executor --network sepolia
```

## Available networks:
- `sepolia`: Ethereum testnet (default in this guide)
- `rococo`: Polkadot ecosystem testnet
- `local`: Run a local instance (for dev/testing)

You must also set the corresponding environment variable in `.env`:
```
T3RN_EXECUTOR_NETWORK=sepolia
```
