#!/bin/bash

usage(){
  echo "Call setup environment with optional flags:"
  echo "  [-np | --no_prereq]: Don't update/upgrade or install docker"
  echo "  [-nu | --no_update]: Don't update/upgrade"
  echo "  [-nd | --no_docker]: Don't install docker"
  echo "  [-nn | --no_nano]: Don't install nano"
  echo "  [-nv | --no_vim]: Don't install vim"
  echo "  [-nt | --no_tmux]: Don't install tmux"
  echo "  [-ng | --no_git]: Don't install git"
  echo "  [-nte | --no_terminal]: Don't setup the terminal with zsh and its trimmings"
  echo "  [-nz | --no_zsh]: Don't install zsh"
  echo "  [-nomz | --no_ohmyzsh]: Don't install oh-my-zsh"
  echo "  [-npow | --no_powerlevel10k]: Don't install powerlevel10k theme"
  echo "  [-npy | --no_python]: Don't install python (using pyenv)"
  echo "  [-npg | --no_postgres]: Don't install postgresql"
  echo "  [-ncus | --no_custom]: Don't install custom commands"
  echo "  [-h | --help]: This usage page"
}

update_os(){
  echo "SETUP SCRIPT: Performing OS update..."
  sudo apt upgrade -y
  echo "SETUP SCRIPT: Performing OS update...COMPLETE!"
}

install_docker(){
  echo "SETUP SCRIPT: Performing docker install..."
  
  # Remove old versions
  sudo apt-get remove -y docker docker-engine docker.io containerd runc
  # Install prerequistes
  sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
  # Add the official GPG key
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  # Add the stable repo
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  # Update package index
  sudo apt-get update
  # Install Docker
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io
  echo "SETUP SCRIPT: Performing docker install...COMPLETE!"
}

install_nano(){
  echo "SETUP SCRIPT: Installing nano..."
  sudo apt install -y nano
  echo "SETUP SCRIPT: Installing nano...COMPLETE!"
}

install_vim(){
  echo "SETUP SCRIPT: Installing vim..."
  sudo apt install -y vim
  echo "SETUP SCRIPT: Installing vim...COMPLETE!"
}

install_tmux(){
  echo "SETUP SCRIPT: Installing tmux..."
  sudo apt install -y tmux
  echo "SETUP SCRIPT: Installing tmux...COMPLETE!"
}

install_git(){
  echo "SETUP SCRIPT: Installing Git..."
  sudo apt install -y git
  echo "SETUP SCRIPT: Installing Git...COMPLETE!"
}

install_zsh(){
  echo "SETUP SCRIPT: Installing zsh..."
  sudo apt-get install -y zsh
  sudo chsh -s $(which zsh)
  echo "SETUP SCRIPT: Installing zsh...COMPLETE!"
}

install_oh_my_zsh(){
  echo "SETUP SCRIPT: Installing oh-my-zsh..."
  sudo sudo apt-get install -y curl git zsh
  sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended" 
  echo "SETUP SCRIPT: Installing oh-my-zsh...COMPLETE!"
}

install_powerlevel10k(){
  echo "SETUP SCRIPT: Installing powerlevel10k..."
  sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  cp ~/.zshrc ~/.zshrc_setup_dev_env_backup
  cp -f zshrc.template ~/.zshrc
  # If we are installing custom commands
  if [[ $# -eq 1 ]]; then
    printf "\n#setup_dev_env custom commands\nsource \$HOME/bin/%s_dev_env_commands.sh" $1 >> ~/.zshrc
  fi
  sed -i 's@<HOME>@'$HOME'@' ~/.zshrc
  cp -f p10k.zsh.template ~/.p10k.zsh
  echo "SETUP SCRIPT: Installing powerlevel10k...COMPLETE!"
}

install_python(){
  echo "SETUP SCRIPT: Installing Python (with pyenv, poetry)..."
  sudo apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
  # pyenv
  curl https://pyenv.run | bash
  # poetry
  curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
  # HERE --no-modify-path to installer
  # might need to do this: exec bash
  echo "SETUP SCRIPT: Installing Python (with pyenv, poetry)...COMPLETE!"
}

install_postgres(){
  echo "SETUP SCRIPT: Installing Postgresql..."
  sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
  sudo apt-get update
  sudo apt-get install postgresql
  echo "SETUP SCRIPT: Installing Postgresql...COMPLETE!"
}

install_commands(){
  com_prefix=$1
  echo "SETUP SCRIPT: Installing Custom Commands..."
  mkdir -p ~/bin
  cp -f _prefix_dev_env_commands.sh ~/bin/${com_prefix}_dev_env_commands.sh
  sed -i 's@_prefix@'${com_prefix}'@' ~/bin/${com_prefix}_dev_env_commands.sh
  echo "SETUP SCRIPT: Installing Custom Commands...COMPLETE!"
}

do_prereq=true
do_update=true
do_docker=true
do_nano=true
do_vim=true
do_tmux=true
do_git=true
do_terminal=true
do_zsh=true
do_ohmyzsh=true
do_powerlevel10k=true
do_python=true
do_postgres=true
do_commands=true

# Parse command line args
while [ "$1" != "" ]; do
  case $1 in
    -np | --no_prereq )
      do_prereq=false
      ;;
    -nu | --no_update )
      do_update=false
      ;;
    -nd | --no_docker )
      do_docker=false
      ;;
    -nn | --no_nano )
      do_nano=false
      ;;
    -nv | --no_vim )
      do_vim=false
      ;;
    -nt | --no_tmux )
      do_tmux=false
      ;;
    -ng | --no_git )
      do_git=false
      ;;
    -nte | --no_terminal )
      do_terminal=false
      ;;
    -nz | --no_zsh )
      do_zsh=false
      ;;
    -nomz | --no_ohmyzsh )
      do_ohmyzsh=false
      ;;      
    -npow | --no_powerlevel10k )
      do_powerlevel10k=false
      ;;     
    -npy | --no_python )
      do_python=false
      ;;
    -npg | --no_postgres )
      do_postgres=false
      ;;
    -ncus | --no_custom)
      do_commands=false
      ;;
    -h | --help )
      usage
      exit 0
      ;;
    * ) 
      usage
      exit 1
      ;;
  esac
  shift
done

if [ "$do_commands" = "true" ]
then
  echo "What is the prefix you would like for your dev env commands? (Will be <prefix>_<command_name>)."
  read prefix
  echo "$prefix set"
fi

sudo apt update

# main
if [ "$do_prereq" = "true" ]
then
  if [ "$do_update" = "true" ]
  then
    update_os
  fi

  if [ "$do_docker" = "true" ]
  then
    install_docker
  fi
fi

if [ "$do_nano" = "true" ]
then
  install_nano
fi

if [ "$do_vim" = "true" ]
then
  install_vim
fi

if [ "$do_tmux" = "true" ]
then
  install_tmux
fi

if [ "$do_git" = "true" ]
then
  install_git
fi

if [ "$do_terminal" = "true" ]
then
  if [ "$do_zsh" = "true" ]
  then
    install_zsh
  fi

  if [ "$do_ohmyzsh" = "true" ]
  then
    install_oh_my_zsh
  fi

  if [ "$do_powerlevel10k" = "true" ]
  then
    if [ "$do_commands" = "true" ]
    then
      install_powerlevel10k $prefix
    else
      install_powerlevel10k
    fi
  fi
fi

if [ "$do_python" = "true" ]
then
  install_python
fi

if [ "$do_postgres" = "true" ]
then
  install_postgres
fi

if [ "$do_commands" = "true" ]
then
  install_commands $prefix
fi

echo "                   SETUP SCRIPT COMPLETE"
echo "------------------------------------------------------------"
if [ "$do_zsh" = "true" ]
then
  echo "To start zsh, just run: zsh"
fi
if [ "$do_python" = "true" ]
then
  echo "If you want to install, python, let's say version 3.8.3, do:"
  echo "pyenv install 3.8.3"
  echo "pyenv shell 3.8.3"
  echo "source .zshrc"
fi
if [ "$do_ohmyzsh" = "true" ]
then
  echo "Don't forget to install meslo fonts (maybe also powerline font)!"
fi
echo "------------------------------------------------------------"
