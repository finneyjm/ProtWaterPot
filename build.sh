#!/bin/bash

#####################################################
### Compiling the Bowman PES for Protanated Water ###
#####################################################

# This is specifically if you want to use this PES
# with f2py and don't want to have to write your
# walkers to file over and over

# Make some libraries to store all the terms and such
mkdir lib
cd lib
mkdir watlib
mkdir pes_lib
cd pes_lib
mkdir inv
cd ../../
# Compile the libraries for the 2-body interactions
cd source_code/water_lib/2-body/pes
./mke
cd ../dms
./mke
cd ../

# Move these new libraries to the lib folder for later
cp pes/libpes2b.a dms/libdms2b.a ../../../lib/watlib

# Compile the libraries for the 3-body interactions
cd ../3-body
make

# Move this library to the lib folder
cp -r libpes3b.a mod3b ../../../lib/watlib

# Compile the libraries for the PES
cd ../../pes_lib/inv
make
cd ../pes-xyz
make
cp *.a ..
cd ..

# Moving everything to the lib folder
cp -r *.a mod ../../lib/pes_lib

# Compile the PES and then use f2py
cd ../../PES
make getpot
make -f MakefileJacob ProtWaterPot

# Move the .so file to a better location
cp *.so ../f2py_prot_water_pot
