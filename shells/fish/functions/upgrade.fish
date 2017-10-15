function upgrade --description "Upgrade the system"
    sudo apt update
    and sudo apt upgrade
    and sudo apt full-upgrade
    and sudo apt autoremove
    sudo tlmgr update --self --all
    sudo npm update -g
end
