FROM ubuntu

RUN apt-get update &&  \
    apt-get install -y git wget curl nano && \
    git config --global user.email "hugues.carange@hotmail.com" && \
    git config --global user.name "huguesCarange"

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.30.1/install.sh | bash && \
    export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
    nvm install v8.9.0 && \
    npm install -g npm && \
    npm install -g cordova ionic && \
    ionic start MonApp blank --no-interactive && \
    cd MonApp && \
    git clone https://github.com/arjunsk/ionic_simple_calculator.git && \
    cd ionic_simple_calculator && \
    npm install node-sass
    
CMD export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
    cd MonApp; \
    cd ionic_simple_calculator; \
    nvm use v8.9.0 && \
    ionic serve
    
EXPOSE 8100
