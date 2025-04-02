#!/bin/bash
set -a
source /app/.env
set +a
exec executor
