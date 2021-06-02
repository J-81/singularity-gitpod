FROM gitpod/workspace-full

# Install custom tools, runtime, etc.
RUN sudo apt-get update && sudo apt-get install -y \
    build-essential \
    uuid-dev \
    libgpgme-dev \
    squashfs-tools \
    libseccomp-dev \
    wget \
    pkg-config \
    git \
    cryptsetup-bin && sudo rm -rf /var/lib/apt/lists/*

# Install Singularity (Go is already installed)
RUN export VERSION=3.8.0 && # adjust this as necessary \
    wget https://github.com/sylabs/singularity/releases/download/v${VERSION}/singularity-ce-${VERSION}.tar.gz && \
    tar -xzf singularity-ce-${VERSION}.tar.gz && \
    rm -rf singularity-ce-${VERSION}.tar.gz && \
    cd singularity-ce-${VERSION} && \
    ./mconfig && \
    make -C ./builddir && \
    sudo make -C ./builddir install

RUN echo ". /usr/local/etc/bash_completion.d/singularity" >> ${HOME}/.bashrc
