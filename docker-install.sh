#!/bin/bash
# Update and upgrade Ubuntu
    sudo apt update
    sudo apt -y upgrade
    sudo apt -y dist-upgrade
    sudo apt -y autoremove
    sleep 0.5
    
    # Again :D
    sudo apt -y autoclean
    sudo apt -y clean
    sudo apt update
    sudo apt -y upgrade
    sudo apt -y dist-upgrade
    sudo apt -y autoremove


    # Check if UFW is installed
if ! command -v ufw &> /dev/null; then
    echo "UFW is not installed. Attempting to install..."
    if [[ $(lsb_release -rs) == "22.04" ]]; then
        sudo apt update
        sudo apt install ufw
    elif [[ $(lsb_release -rs) == "20.04" ]]; then
        sudo apt update
        sudo apt install ufw
    elif [[ $(lsb_release -rs) == "18.04" ]]; then
        sudo apt update
        sudo apt install ufw
    elif [[ -f /etc/redhat-release ]]; then
        sudo yum install -y ufw
    else
        echo "Unsupported Linux distribution. Please install UFW manually."
        exit 1
    fi

    # Enable UFW
    sudo ufw enable

    echo "UFW has been installed and enabled."
else
    echo "UFW is already installed."
fi


# Enable the Uncomplicated Firewall (UFW)
sudo ufw enable
#sudo ufw enable

# Allow SSH (port 22) for remote access
sudo ufw allow 22 comment 'Allow SSH Access'
sudo ufw allow 80 comment 'Allow HTTP Access'
sudo ufw allow 443 comment 'Allow HTTPS Access'


sudo apt update && sudo apt upgrade -y && sudo apt install -y apt-transport-https ca-certificates curl software-properties-common && curl -fsSL https://get.docker.com | sh

