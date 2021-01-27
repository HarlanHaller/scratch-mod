#!/bin/bash
FOUND=""

setup()
{
    if [ $1 = "npm" -o $1 = "yarn" ]
    then
        cd scratch-gui
        echo "installing node modules in scratch-gui"
        sleep 3
        `$1 install`
        cd ../scratch-blocks
        echo "installing node modules in scratch-blocks"
        sleep 3
        `$1 install`
        echo "linking to scratch blocks"
        sleep 3
        `sudo $1 link`
        cd ../scratch-gui
        `$1 link scratch-blocks`
        cd ../scratch-vm
        echo "installing node modules in scratch-vm"
        sleep 3
        `$1 install`
        echo "linking to scratch blocks"
        sleep 3
        `sudo $1 link`
        cd ../scratch-gui
        `$1 link scratch-vm`
    else exit 1
    fi;
}
tester()
{
    echo `$1 -v`
}

get_choice()
{
    echo "wich do you want to use (npm/yarn)"
    read choice;
    if [ $choice = "yarn" ];
    then return 1;
    else return 0;
    fi; 
}

check_commands()
{
    echo "checking for npm..."
    if which npm > /dev/null;
    then echo "npm found"; FOUND+="npm";
    else echo "npm not found";
    fi;
    echo "checking for yarn..."
    if which yarn > /dev/null;
    then echo "yarn found"; FOUND+="yarn";
    else echo "yarn not found";
    fi;
    if [ ${#FOUND} -ne 4 ];
    then
        choice="npm"
        get_choice
        if [ $? -eq 1 ]
        then choice="yarn"
        fi;
        setup $choice;
    else setup $FOUND
    fi;
}

echo "Are you sure you whant to run setup comands";
echo "the setup function will install npm modules and link files (y/N)";
read conf;
if [ ${conf,} = "y" ]
then check_commands;
fi;