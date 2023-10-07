#!/bin/bash
# Update and upgrade Ubuntu
# Function to check if the system is Debian/Ubuntu-based
is_debian() {
    [ -f /etc/debian_version ]
}

# Function to check if the system is Red Hat-based
is_redhat() {
    [ -f /etc/redhat-release ]
}

# Update and upgrade based on the distribution
if is_debian; then
    sudo apt update
    sudo apt -y upgrade
    sudo apt -y dist-upgrade
    sudo apt -y autoremove
    sleep 0.5
    sudo apt -y autoclean
    sudo apt -y clean
elif is_redhat; then
    sudo yum check-update
    sudo yum -y update
    sudo yum -y upgrade
    sudo yum -y autoremove
    sleep 0.5
    sudo yum clean all
else
    echo "Unsupported distribution. Exiting."
    exit 1
fi



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
    yes | sudo ufw enable
    #sudo ufw enable

# Allow SSH (port 22) for remote access
sudo ufw allow 22 comment 'Allow SSH Access'
sudo ufw allow 80 comment 'Allow HTTP Access'
sudo ufw allow 443 comment 'Allow HTTPS Access'


# Update and install Docker based on the distribution
if is_debian; then
    sudo apt update && sudo apt upgrade -y && sudo apt install -y apt-transport-https ca-certificates curl software-properties-common && curl -fsSL https://get.docker.com | sh
elif is_redhat; then
    sudo yum check-update
    sudo yum -y update
    sudo yum install -y yum-utils device-mapper-persistent-data lvm2
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install -y docker-ce docker-ce-cli containerd.io
else
    echo "Unsupported distribution. Exiting."
    exit 1
fi

# Verify Docker installation
sudo docker run hello-world

# Check if the system needs to reboot
if [ -f /var/run/reboot-required ]; then
    echo "The system needs to reboot."
    
    # Ask for confirmation to reboot
    while true; do
        read -p "Do you want to reboot now? (y/n) " choice
        case "$choice" in 
            y|Y ) 
                echo "Rebooting now..."
                sudo reboot
                ;;
            n|N ) 
                echo "Reboot cancelled."
                break
                ;;
            * ) 
                echo "Invalid input. Please enter 'y' or 'n'."
                ;;
        esac
    done
else
    echo "The system does not need to reboot."
fi


