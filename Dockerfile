FROM debian
MAINTAINER Ralph Giles <giles@mozilla.com>

# Update image base.
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y curl git

# Set up a user.
ENV USER node
ENV HOME /home/${USER}
RUN useradd -d ${HOME} -m ${USER}
WORKDIR ${HOME}
USER ${USER}

# Install nvm.
ENV NVM_DIR ${HOME}/.nvm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
RUN . ~/.nvm/nvm.sh; nvm install 0.10

# Clone vtt.js source.
RUN git clone https://github.com/mozilla/vtt.js

# Setup and run the tests.
CMD . ~/.nvm/nvm.sh; cd vtt.js && git pull && npm install && npm test
