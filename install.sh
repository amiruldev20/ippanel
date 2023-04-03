# AUTO INSTALL DPANELCP
echo "installing nvm.."
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
echo "add path nvm.."
source ~/.profile
source ~/.nvm/nvm.sh
echo "installing nodejs V19.8.1..."
nvm i v19.8.1
nvm install --tls
echo "installing pm2..."
npm i pm2
echo "done!!"
