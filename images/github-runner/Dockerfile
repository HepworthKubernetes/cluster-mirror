FROM myoung34/github-runner:latest

RUN sh -c '\
  KUBECTL_VERSION=$(curl -s https://dl.k8s.io/release/stable.txt) && \
  curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" && \
  install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
  rm kubectl \
'

