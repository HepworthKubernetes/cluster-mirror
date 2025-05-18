FROM docker:20.10-dind

# Install GitHub runner dependencies
RUN apk add --no-cache bash curl git jq python3 py3-pip coreutils

LABEL org.opencontainers.image.source https://github.com/travishepworth/kubernetes

# Add GitHub runner manually
ENV RUNNER_VERSION=2.316.0

RUN mkdir -p /runner
WORKDIR /runner
RUN curl -LO https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    tar -xzf actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    rm actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD []
