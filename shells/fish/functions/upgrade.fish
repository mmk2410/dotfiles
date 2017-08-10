function upgrade --description "Upgrade the system"
    sudo apt-get update
    and sudo apt-get upgrade
    and sudo apt-get dist-upgrade
    and sudo apt-get autoremove
    sudo tlmgr update --self --all
    sudo npm update -g
end
