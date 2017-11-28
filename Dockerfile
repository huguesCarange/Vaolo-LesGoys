FROM ubuntu

RUN apt-get update && \
    apt-get install -y nano git curl wget python build-essential && \
    git config --global user.email "ced.toup@hotmail.com" && \
    git config --global user.name "cedtoup"

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.5/install.sh | bash && \
    export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
    nvm install v8.9.0 && \
    npm install -g npm && \
    npm install -g cordova ionic && \
    npm install karma --save-dev && \
    npm install karma-jasmine --save-dev && \
    npm install -g karma-cli

# Install Google Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get update && apt-get install -y google-chrome-stable

RUN cd /home && \
    git clone https://github.com/ionic-team/ionic-unit-testing-example.git && \
    cd ionic-unit-testing-example && \
    git checkout ionic-v2-branch
    
COPY ./karma.conf.js /home/ionic-unit-testing-example/test-config/

COPY ./package.json /home/ionic-unit-testing-example/

RUN cd /home/ionic-unit-testing-example && \
    export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
    npm install node-sass && \
    npm install && \
    npm run test


EXPOSE 8100
