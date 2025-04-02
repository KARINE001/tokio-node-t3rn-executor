
# 📦 Version History — T3RN Executor Docker Pack

## v1.1 – April 2, 2025
- Updated `.env` with new network RPCs and higher gas limits
- Improved `check_t3rn_node.sh` script (more readable output + error detection)
- Refactored `Dockerfile` to fetch latest executor binary
- Cleaner `entrypoint.sh` with network autodetection
- Added Prometheus port `9090` in `docker-compose.yml`

## v1.0 – March 29, 2025
- Initial Docker-based node setup
- Basic monitoring script and env template
