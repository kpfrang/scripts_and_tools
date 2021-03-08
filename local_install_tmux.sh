#!/bin/bash
# local installation of tmux without root rights. Installation of ncurses fails on afs systems. So make sure
# install on a different file system.


if [ -z "$1" ] ; then
    echo "usage: $0 <install directory>"
    exit 1
fi

###########################
##### Setup directory #####
###########################
DIR=$1
echo "Installing tmux to ${DIR}. Make sure that this is not a afs directory (ncurses installation will fail otherwise)"

# create our directories
mkdir -p $DIR $DIR/tmux_tmp
cd $DIR/tmux_tmp


################################
##### download and install #####
################################

echo "Downloading source files for tmux, libevent and ncurses ${DIR}"

# download source files for tmux, libevent, and ncurses
wget https://github.com/tmux/tmux/releases/download/3.1b/tmux-3.1b.tar.gz
wget https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz
wget https://invisible-island.net/datafiles/release/ncurses.tar.gz

####################
##### libevent #####
echo "Installing libevent"
tar xvzf libevent-2.1.12-stable.tar.gz
cd libevent-2.1.12-stable
./configure --prefix=$DIR/ --enable-shared
make && make install
cd ..

###################
##### ncurses #####
echo "Installing ncurses"
tar xvzf ncurses.tar.gz
cd ncurses-6.2
./configure --prefix=$DIR --with-shared --with-termlib --enable-pc-files --with-pkg-config-libdir=$DIR/lib/pkgconfig
make && make install
cd ..

################
##### tmux #####
echo "Installing tmux"
tar xvzf tmux-3.1b.tar.gz
cd tmux-3.1b
PKG_CONFIG_PATH=$DIR/lib/pkgconfig ./configure --prefix=$DIR
make && make install

# cleanup
echo "Deleting tmux_tmp containing source files."
rm -rf $DIR/tmux_tmp

# Add the following in your .zshrc:
echo "Adding following lines to .zshrc:"
echo "" >> ~/.zshrc
echo "export PATH=${DIR}/bin:\$PATH"
echo "export PATH=${DIR}/bin:\$PATH" >> ~/.zshrc
echo "export LD_LIBRARY_PATH=${DIR}/lib:\$LD_LIBRARY_PATH"
echo "export LD_LIBRARY_PATH=${DIR}/lib:\$LD_LIBRARY_PATH" >> ~/.zshrc
echo "export MANPATH=${DIR}/share/man:\$MANPATH"
echo "export MANPATH=${DIR}/share/man:\$MANPATH" >> ~/.zshrc
