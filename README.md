# setup-dev-env
Setup development environment on a "new" box.

Personally designed for the author's development environment and currently only supports Linux.

## Install
To install, clone this repository then run `make install`. This will run the command with default arguments (all items installed).

If you want to run the setup script with some items turned off, run `./src/setup_dev_env_linux.sh --help` to see which items you can install or not install. 

## Custom Commands
If you want to install the custom commands in `./src/_prefix_dev_env_commands.sh`, supply the `-pre` argument to the install script. This will install the custom commands in a `bin` folder in the user's home directory.

## Todo
- Complete setting up automatic testing to ensure that everything is working correctly.
- Support other operating systems.
- To add:
  - [homebrew](https://brew.sh/)
  - poetry
  - [fzf](https://github.com/junegunn/fzf#using-homebrew)
  - [ripgrep](https://github.com/BurntSushi/ripgrep)
  - [bat](https://github.com/sharkdp/bat)

## License
[GNU v3](LICENSE)
