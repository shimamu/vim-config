#!/bin/sh

# Set up script for Linux.

ln -sf -T `pwd`/.vimrc ~/.vimrc
ln -sf -T `pwd`/.gvimrc ~/.gvimrc

mkdir -p ~/.vim
cp -n .vimrc.local.example ~/.vim/.vimrc.local
