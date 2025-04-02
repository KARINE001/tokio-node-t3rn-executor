FROM debian:bullseye-slim

WORKDIR /app

RUN apt-get update && apt-get install -y curl tar && rm -rf /var/lib/apt/lists/*

# Change this to pin to a version, or keep dynamic for latest
ARG EXECUTOR_VERSION=0.61.0

RUN curl -LO https://github.com/t3rn/executor-release/releases/download/v${EXECUTOR_VERSION}/executor-linux-v${EXECUTOR_VERSION}.tar.gz && \
    tar -xzf executor-linux-v${EXECUTOR_VERSION}.tar.gz && \
    rm executor-linux-v${EXECUTOR_VERSION}.tar.gz

ENV PATH="/app/executor/executor/bin:$PATH"

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
