FROM alpine:3.19

# Install base tools and linters
RUN apk add --no-cache \
    bash \
    git \
    curl \
    jq \
    python3 \
    py3-pip \
    py3-setuptools \
    py3-wheel \
    py3-virtualenv \
    shellcheck \
    hadolint \
    yamllint \
    kubeconform

ENTRYPOINT ["/bin/bash"]
