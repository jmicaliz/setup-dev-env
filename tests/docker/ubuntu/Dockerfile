FROM ubuntu:bionic

RUN apt-get update && \
    apt-get -y install sudo

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

WORKDIR /home/docker

COPY src ./

RUN chmod a+x *.sh

USER docker

SHELL ["/bin/bash", "-c"]

# To test script
# ENTRYPOINT ["/bin/bash", "-c", "echo Test"]
# To get into it
# CMD ["/bin/bash"]
