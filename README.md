# ubuntu-server-docker-setup
Automated Ubuntu Docker Setup Script


1. Update, Upgrade, and Clean the server:
    - _Update_
    - _Upgrade_
    - _Dist-Upgrade_
    - _AutoRemove_
    - _AutoClean_
    - _Clean_


3. Install Useful Packages:

_`apt-transport-https`_ _`ca-certificates`_ _`curl`_ _`software-properties-common`_ and in the end _`curl -fsSL https://get.docker.com | sh`_

## Run
#### **Tested on:** Ubuntu 18+, Debian 11+

```
wget "https://raw.githubusercontent.com/DanielNoohi/ubuntu-server-docker-setup/main/docker-install.sh" -O docker-install.sh && chmod +x docker-install.sh && bash docker-install.sh
```
