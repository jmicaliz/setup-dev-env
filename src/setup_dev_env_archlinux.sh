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
  echo "  [nte | --no_terminal]: Don't setup the terminal with zsh and its trimmings"
  echo "  [-nz | --no_zsh]: Don't install zsh"
  echo "  [-nomz | --no_ohmyzsh]: Don't install oh-my-zsh"
  echo "  [-npow | --no_powerlevel10k]: Don't install powerlevel10k theme"
  echo "  [-npy | --no_python]: Don't install python (using pyenv)"
  echo "  [-npg | --no_postgres]: Don't install postgresql"
  echo "  [-h | --help]: This usage page"
}

update_os(){
  echo "SETUP SCRIPT: Performing OS update..."
  sudo pacman -Syu --noconfirm
  echo "SETUP SCRIPT: Performing OS update...COMPLETE!"
}

install_docker(){
  echo "SETUP SCRIPT: Performing docker install..."
  sudo pacman -Syu --noconfirm docker
  echo "SETUP SCRIPT: Performing docker install...COMPLETE!"
}

install_nano(){
  echo "SETUP SCRIPT: Installing nano..."
  sudo pacman -Syu --noconfirm nano
  echo "SETUP SCRIPT: Installing nano...COMPLETE!"
}

install_vim(){
  echo "SETUP SCRIPT: Installing vim..."
  sudo pacman -Syu --noconfirm vim
  echo "SETUP SCRIPT: Installing vim...COMPLETE!"
}

install_tmux(){
  echo "SETUP SCRIPT: Installing tmux..."
  sudo pacman -Syu --noconfirm tmux
  echo "SETUP SCRIPT: Installing tmux...COMPLETE!"
}

install_git(){
  echo "SETUP SCRIPT: Installing Git..."
  sudo pacman -Syu --noconfirm git
  echo "SETUP SCRIPT: Installing Git...COMPLETE!"
}

install_zsh(){
  echo "SETUP SCRIPT: Installing zsh..."
  sudo pacman -Syu --noconfirm zsh
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
  sed -i 's@<HOME>@'$HOME'@' ~/.zshrc
  cp -f p10k.zsh.template ~/.p10k.zsh
  echo "SETUP SCRIPT: Installing powerlevel10k...COMPLETE!"
}

install_python(){
  echo "SETUP SCRIPT: Installing Python (with pyenv)..."
  sudo apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
  curl https://pyenv.run | bash
  # might need to do this: exec bash
  echo "SETUP SCRIPT: Installing Python (with pyenv)...COMPLETE!"
}

install_postgres(){
  echo "SETUP SCRIPT: Installing Postgresql..."
  sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
  sudo apt-get update
  sudo apt-get install postgresql
  echo "SETUP SCRIPT: Installing Postgresql...COMPLETE!"
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
    install_powerlevel10k
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
