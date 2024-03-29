#!/bin/bash

source ./env.sh ${1}


pushd ${BUILDROOT}

if [ -d ./build_llvm_15 ]; 
then 
  rm -rf ./build_llvm_15
fi


mkdir  ./build_llvm_15
pushd ./build_llvm_15

cmake -G "Ninja" \
-DCMAKE_CXX_COMPILER="g++" \
-DCMAKE_CXX_LINK_FLAGS="-Wl,-rpath,${GCC_HOME}/lib64 -L${GCC_HOME}/lib64" \
-DCMAKE_CXX_STANDARD=14 \
-DCMAKE_CXX_EXTENSIONS=OFF \
-DCMAKE_C_STANDARD=99 \
-DLLVM_ENABLE_TERMINFO="OFF" \
-DCMAKE_C_COMPILER="gcc" \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/llvm-15  \
-DLLVM_TARGETS_TO_BUILD="PowerPC;NVPTX" \
-DLLVM_ENABLE_ZLIB="OFF" \
-DBUILD_SHARED_LIBS="ON" \
-DLLVM_ENABLE_RTTI="ON"  \
${SRCROOT}/llvm-project/llvm


cmake --build . -j 32
cmake --install . 
popd
