#!/bin/bash

# Export all variables defined in .env into the environment
set -a
source /app/.env
set +a

# Launch the t3rn executor binary (downloaded in Dockerfile)
exec executor
