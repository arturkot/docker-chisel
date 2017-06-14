FROM debian:jessie

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update
RUN apt-get -y install apt-utils curl apt-transport-https
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash 
RUN source ~/.nvm/nvm.sh \
    && nvm install 7.10 \
    && nvm alias default 7.10 \
    && nvm use default
RUN echo "export NODE_PATH=$NODE_PATH:/root/.nvm/versions/node/v7.10.0/lib/node_modules" >> ~/.bashrc && source ~/.bashrc
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn

ENV NODE_PATH ~/.nvm/versions/node/v7.10.0/lib/node_modules
ENV PATH      ~/.nvm/versions/node/v7.10.0/bin:$PATH

RUN yarn global add  yo
RUN yarn global add generator-chisel
RUN adduser --disabled-password --gecos "" yeoman
RUN mkdir /root/.config
RUN mkdir /root/.config/configstore
RUN touch /root/.config/configstore/insight-yo.json
RUN chown yeoman /root/.config/configstore/insight-yo.json
RUN chmod g+rwx /root /root/.config /root/.config/configstore

WORKDIR app/
