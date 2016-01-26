############################################################
# Copyright (c) 2016 Stefan Kemnitz
# Released under the MIT license
############################################################

# ├─yantis/archlinux-tiny
#   ├─realincubus/docker-clang-build

FROM realincubus/docker-clang-build
MAINTAINER Stefan Kemnitz <kemnitz.stefan@googlemail.com>

RUN pacman --noconfirm -S git bison flex

RUN cd ~ && \
    cd llvm/tools/clang/examples/ && \
    git clone https://github.com/realincubus/ClanPlugin.git && \
    cd ClanPlugin && \
    git submodule update --init --recursive

RUN cd ~ && \
    cd llvm/tools/clang/examples/ && \
    echo "add_subdirectory(ClanPlugin)" >> CMakeLists.txt

# to regenerate build
RUN cd ~ && \
    cd build/ && \
    make

RUN cd ~ && \
    cd build/tools/clang/examples/ClanPlugin/ && \
    make ClanPlugin -j 8 
