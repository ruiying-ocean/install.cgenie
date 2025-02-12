#!/bin/bash
### CGENIE LIBRARIES SETUP AND INSTALL FOR HPC ###

# Set installation directory to ~/.local
INSTALL_DIR="$HOME/.local"
mkdir -p $INSTALL_DIR

cd $HOME

### Install netcdf-4.6.1 ###
# if [ ! -f v4.6.1.tar.gz ]; then
#     wget https://github.com/Unidata/netcdf-c/archive/refs/tags/v4.6.1.tar.gz
# fi
# tar xzf v4.6.1.tar.gz
cd netcdf-c-4.6.1
./configure --prefix=$INSTALL_DIR --disable-netcdf-4 --disable-dap
make clean && make check && make install
cd ~

### Install netcdf-cxx-4.2 ###
# if [ ! -f netcdf-cxx-4.2.tar.gz ]; then
#     wget https://downloads.unidata.ucar.edu/netcdf-cxx/4.2/netcdf-cxx-4.2.tar.gz
# fi
# tar xzf netcdf-cxx-4.2.tar.gz
cd netcdf-cxx-4.2
export CPPFLAGS="-I$INSTALL_DIR/include" LDFLAGS="-L$INSTALL_DIR/lib"
./configure --prefix=$INSTALL_DIR
make clean && make check && make install
cd ~

### Install netcdf-fortran-4.4.4 ###
# if [ ! -f v4.4.4.tar.gz ]; then
#     wget https://github.com/Unidata/netcdf-fortran/archive/refs/tags/v4.4.4.tar.gz
# fi
# tar xzf v4.4.4.tar.gz
cd netcdf-fortran-4.4.4
export LD_LIBRARY_PATH="$INSTALL_DIR/lib"
./configure --prefix=$INSTALL_DIR
make clean && make check && make install
cd ~


wget https://download.gnome.org/sources/libxml2/2.13/libxml2-2.13.5.tar.xz
tar xzf libxml2-2.13.5.tar.gz
cd libxml2-2.13.5
./configure --prefix=$INSTALL_DIR
make && make install
cd ~

wget https://download.gnome.org/sources/libxslt/1.1/libxslt-1.1.42.tar.xz
tar xzf libxslt-1.1.42.tar.gz
cd libxslt-1.1.42
./configure --prefix=$INSTALL_DIR --with-libxml-prefix=$INSTALL_DIR
make && make install
cd ~

### Create cgenie.jobs directory ###
mkdir -p $HOME/cgenie.jobs

### Test cGENIE installation ###
cd cgenie.muffin/genie-main
make cleanall && make testbiogem
echo "If the output reads '*TEST OK*', cGENIE is installed successfully. Otherwise, check for errors."
