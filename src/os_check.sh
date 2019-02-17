#!/bin/sh

usage(){
  echo "Call setup environment with optional flags:"
  echo "  [-h | --help]: This usage page"
}

check_os(){
  unameOut="$(uname -s)"
  case "${unameOut}" in
      Linux*)
        machine=Linux
        ;;
      Darwin*)
        # machine=Mac
        machine=unsupported
        ;;
      CYGWIN*)
        # machine=Cygwin
        machine=unsupported
        ;;
      MINGW*)
        # machine=MinGw
        machine=unsupported
        ;;
      *)
        echo "Machine is unknown ${unameOut}" 1>&2
        machine=unsupported
        ;;
  esac
  echo ${machine}
}

# Parse command line args
while [ "$1" != "" ]; do
  case $1 in
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

# Check the OS
os_name=$(check_os)

if [ "$os_name" = "unsupported" ]
then
  exit 1
fi
