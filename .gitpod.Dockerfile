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

RUN sudo mkdir /workspace && sudo chown -R 33333:33333 /workspace

# Install Singularity (Go is already installed)
RUN wget https://github.com/sylabs/singularity/releases/download/v3.8.1/singularity-ce-3.8.1.tar.gz && \
    tar -xzf singularity-ce-3.8.1.tar.gz && \
    cd singularity-ce-3.8.1 && \
    ./mconfig --disable-suid --prefix=/workspace/singularity-gitpod && \
    make -C ./builddir && \
    sudo make -C ./builddir install
    
RUN cd && rm -rf singularity-ce-3.8.*    

RUN echo ". /usr/local/etc/bash_completion.d/singularity" >> ${HOME}/.bashrc
