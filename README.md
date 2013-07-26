Setup Instructions
------------------

1. sudo apt-get install build-essential
1. sudo apt-get install --reinstall libc6-dev
1. sudo apt-get install python-dev
1. sudo apt-get install python-numpy
1. sudo apt-get install python-gdal

1. install hdf5 from source (http://www.hdfgroup.org/ftp/HDF5/current/src/hdf5-1.8.11.tar.bz2)

1. install zlib from source (http://zlib.net/zlib-1.2.8.tar.gz)

1. install netcdf4 from source (ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4.3.0.tar.gz)
    
    LDFLAGS=-L/usr/local/lib CPPFLAGS=-I/usr/local/include ./configure --enable-netcdf-4 --enable-dap --enable-shared --prefix=/usr/local
    make
    make install

1 install netcdf4-python from source (https://netcdf4-python.googlecode.com/files/netCDF4-1.0.4.tar.gz)
