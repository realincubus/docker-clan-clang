############################################################
# Copyright (c) 2016 Stefan Kemnitz
# Released under the MIT license
############################################################

# ├─yantis/archlinux-tiny
#   ├─realincubus/docker-clang-build
#     ├─realincubus/pet

FROM realincubus/pet
MAINTAINER Stefan Kemnitz <kemnitz.stefan@googlemail.com>

RUN pacman --noconfirm -Rdd texinfo-fake && \
    pacman --noconfirm -S git bison flex autogen autoconf automake libtool texinfo && \
    cd ~ && \
    cd llvm/tools/clang/examples/ && \
    git clone https://github.com/realincubus/ClanPlugin.git && \
    cd ClanPlugin && \
    git submodule update --init --recursive && \
    cd ~ && \
    cd llvm/tools/clang/examples/ && \
    echo "add_subdirectory(ClanPlugin)" >> CMakeLists.txt && \
    cd ~ && \
    cd llvm/tools/clang/examples/ClanPlugin/pluto_src/ && \
    ./local_install.sh && \
    make -j 3 && \
    make install

# to regenerate build
RUN cd ~ && \
    cd build/ && \
    make && \
    cd ~ && \
    cd build/tools/clang/examples/ClanPlugin/ && \
    make ClanPlugin
