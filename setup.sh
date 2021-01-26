#!/bin/bash
setup()
{
    cd scratch-gui
    npm install
    cd ../scratch-blocks
    npm install
    sudo npm link
    cd ../scratch-gui
    npm link scratch-blocks
    cd ../scratch-vm
    npm install
    sudo npm link
    cd ../scratch-gui
    npm link scratch-vm
}

echo "Are you sure you whant to run setup comands"
echo "the setup function will install node modules and link files (y/N)"
read conf
if [ $conf = "y" ] 
then
setup
fi
if [ $conf = "Y" ]
then
setup
fi