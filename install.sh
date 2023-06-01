# AUTO INSTALL DXCP.
echo "installing nvm.."
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
echo "add path nvm.."
source ~/.profile
echo "installing nodejs V19.8.1..."
nvm i v19.8.1
nvm install --tls
echo "installing pm2..."
npm i pm2
echo "export path pm2"
mkdir ~/.bin
ln -s ~/node_modules/pm2/bin/pm2 ~/bin/pm2
echo 'export PATH=$PATH:~/bin' >> ~/.bashrc
source ~/.bashrc
echo "done!!"
