FROM debian:buster-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install -y curl gpg wget

RUN wget https://github.com/mikefarah/yq/releases/download/v4.9.6/yq_linux_amd64 -O /usr/bin/yq && \
    chmod +x /usr/bin/yq

RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null && \
    apt-get update -y && \
    apt-get install -y gh

RUN git config --global user.email "62192187+cisaacstern@users.noreply.github.com" && git config --global user.name "feedstockcreation"

COPY action/create_feedstock.sh /create_feedstock.sh

ENTRYPOINT [ "bash", "create_feedstock.sh" ]
