# setup-dev-env
Setup development environment on a "new" box.

Personally designed for the author's development environment and currently only supports certain flavors of Linux.

## Install
To install, clone this repository then run `make install`. This will run the command with default arguments (all items installed).

If you want to run the setup script with some items turned off, run `./src/setup_dev_env_<distro>.sh --help` to see which items you can install or not install. 

## Todo
- Complete setting up automatic testing to ensure that everything is working correctly.
- Support other operating systems.

### Other Things to Install
- Homebrew
- [fzf](https://github.com/junegunn/fzf)

## License
[GNU v3](LICENSE)
