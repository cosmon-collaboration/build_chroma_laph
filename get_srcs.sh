#!/bin/bash

cd ../
mkdir src
cd src

git clone https://github.com/usqcd-software/qmp.git
cd qmp
git checkout 3010fef
cd ../

git clone https://github.com/HDFGroup/hdf5.git
cd hdf5
git checkout 1d90890a7b
cd ../


git clone --recursive -b devel https://github.com/usqcd-software/qdpxx.git
cd qdpxx
git checkout 5be45232
cd ../

git clone --recursive -b devel https://github.com/jeffersonlab/qdp-jit.git
cd qdp-jit
git checkout  f51b9d6e
cd ../

git clone -b develop https://github.com/lattice/quda.git
cd quda
git checkout 2758d5cf8
cd ../

git clone --recursive -b devel https://github.com/jeffersonlab/chroma.git
cd chroma
git checkout 4b2e1171a
echo "WARNING: Chroma will need a hack for 3D versions" 
sed -i 's+add_subdirectory(mainprogs/tests)+#add_subdirectory(mainprogs/tests)+g' CMakeLists.txt
sed -i 's+actions/ferm/fermacts/unprec_w12_fermact_w.h+#actions/ferm/fermacts/unprec_w12_fermact_w.h+g' lib/CMakeLists.txt
sed -i 's+actions/ferm/fermacts/unprec_w12_fermact_w.cc+#actions/ferm/fermacts/unprec_w12_fermact_w.cc+g' lib/CMakeLists.txt
cd ../

git clone -b release/15.x https://github.com/llvm/llvm-project

git clone git@github.com:henrymonge/chroma_laph_jit.git
cd chroma_laph_jit
git checkout dd0096a
cd ../




