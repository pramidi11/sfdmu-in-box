FROM debian:stretch-slim
RUN apt-get update -y \
    && apt-get install -y \
        curl \
        apt-utils \
        sudo \
        unzip \
    && curl -sL https://deb.nodesource.com/setup_current.x | sudo bash - \
    && apt-get update \
    && sudo apt-get install -y nodejs \
    #install SFDX
    && npm install sfdx-cli -g \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && sudo ./aws/install \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /root/.config/sfdx \
    && mkdir -p /usr/src/project
#whitelist sfdmu
COPY ./config/sfdx/unsignedPluginAllowList.json /root/.config/sfdx/unsignedPluginAllowList.json
#install sfdmu
RUN sfdx plugins:install sfdmu
WORKDIR /usr/src/project
CMD ["bash"]
