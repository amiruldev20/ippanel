#!/bin/bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash && source ~/.nvm/nvm.sh && nvm install v19.8.1 && npm install pm2 -g
