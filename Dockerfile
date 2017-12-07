FROM ubuntu

RUN apt-get update &&  \
    apt-get install -y git wget curl nano python build-essential && \
    git config --global user.email "hugues.carange@hotmail.com" && \
    git config --global user.name "huguesCarange"

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.30.1/install.sh | bash && \
    export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
    nvm install v8.9.0 && \
    npm install -g npm && \
    npm install -g cordova ionic && \
    cd /home && \
    git clone https://github.com/huguesCarange/Vaolo-LesGoys.git && \
    cd Vaolo-LesGoys && \
    git checkout staging && \
    npm install node-sass && \
    npm install 
    
CMD export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
    cd /home; \
    cd Vaolo-LesGoys; \
    nvm use v8.9.0 && \
    ionic serve --no-interactive
    
EXPOSE 8100
