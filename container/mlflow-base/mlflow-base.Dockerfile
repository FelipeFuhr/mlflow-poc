FROM ubuntu:22.04@sha256:9a0bdde4188b896a372804be2384015e90e3f84906b750c1a53539b585fbbe7f

ENV DEBIAN_FRONTEND=noninteractive 
ENV PYENV_GIT_TAG=v2.2.5
ENV PYENV_ROOT="$HOME/.pyenv"
ENV PATH="$PYENV_ROOT/bin:$PATH"

COPY basic-requirements.txt .
COPY pyenv-installer .

RUN apt-get update                              && \
    apt-get install -y                          \
            python3-pip=22.0.2+dfsg-1ubuntu0.1  \
            curl=7.81.0-1ubuntu1.7              \
            git-all=1:2.34.1-1ubuntu1.8 &&      \
    ./pyenv-installer                           && \
    command -v pyenv >/dev/null                 && \
    eval "$(pyenv init -)"                      && \
    pip3 install pip==23.0.1                    && \
    pip3 install -r basic-requirements.txt      && \
    apt-get install -y                          \
        make=4.3-4.1build1                      \
        build-essential=12.9ubuntu3             \
        libssl-dev=3.0.2-0ubuntu1.8             \
        zlib1g-dev=1:1.2.11.dfsg-2ubuntu9.2     \
        libbz2-dev=1.0.8-5build1                \
        libreadline-dev=8.1.2-1                 \
        libsqlite3-dev=3.37.2-2ubuntu0.1        \
        llvm=1:14.0-55~exp2                     \
        libncursesw5-dev=6.3-2                  \
        xz-utils=5.2.5-2ubuntu1                 \
        tk-dev=8.6.11+1build2                   \
        libxml2-dev=2.9.13+dfsg-1ubuntu0.2      \
        libxmlsec1-dev=1.2.33-1build2           \
        libffi-dev=3.4.2-4                      \
        liblzma-dev=5.2.5-2ubuntu1              && \ 
    pyenv install 3.8.13                        && \
    apt remove -y git-all                       && \
    rm pyenv-installer                          && \
    apt -y autoremove                           