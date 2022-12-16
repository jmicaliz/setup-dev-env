FROM archlinux:base

RUN pacman -Syu --noconfirm sudo && \
    pacman -Syu --noconfirm vi

RUN useradd -m docker && echo "docker:docker" | chpasswd

RUN echo "docker ALL=(ALL)       ALL" >> /etc/sudoers.d/dockeruser

WORKDIR /home/docker

COPY src ./

RUN chmod a+x *.sh

USER docker

SHELL ["/bin/bash", "-c"]

# To test script
# ENTRYPOINT ["/bin/bash", "-c", "echo Test"]
# To get into it
CMD ["/bin/bash"]
