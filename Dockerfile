# Use a lightweight base image
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    tar \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/src/app

# Download and extract the latest t3rn executor binary
RUN curl -s https://api.github.com/repos/t3rn/executor-release/releases/latest \
    | grep -Po '"tag_name": "\K.*?(?=")' \
    | xargs -I {{}} wget https://github.com/t3rn/executor-release/releases/download/{{}}/executor-linux-{{}}.tar.gz \
    && tar -xzf executor-linux-*.tar.gz \
    && rm executor-linux-*.tar.gz

# Copy entrypoint script
COPY entrypoint.sh /usr/src/app/entrypoint.sh
RUN chmod +x /usr/src/app/entrypoint.sh

# Expose necessary ports
EXPOSE 9944 30333

# Set entrypoint
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
