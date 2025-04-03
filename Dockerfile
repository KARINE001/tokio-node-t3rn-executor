FROM debian:bullseye-slim

WORKDIR /app

RUN apt-get update && apt-get install -y curl tar && rm -rf /var/lib/apt/lists/*

# Download the latest release of the t3rn executor binary dynamically
RUN curl -s https://api.github.com/repos/t3rn/executor-release/releases/latest \
    | grep browser_download_url \
    | grep linux \
    | cut -d '"' -f 4 \
    | xargs curl -LO && \
    tar -xzf executor-linux-v*.tar.gz && \
    rm executor-linux-v*.tar.gz

ENV PATH="/app/executor/executor/bin:$PATH"

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]