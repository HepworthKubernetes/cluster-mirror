FROM alpine:3.19

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# Install base tools and linters
RUN apk update && apk add --no-cache \
    bash \
    git \
    curl \
    jq \
    python3 \
    py3-pip \
    shellcheck \
    yamllint \
    kubeconform

ENTRYPOINT ["/bin/bash"]
