source ./env.sh ${1}
pushd ${BUILDROOT}

if [ -d ./build_${CHROMA} ];
then
  rm -rf ./build_${CHROMA}
fi

mkdir  ./build_${CHROMA}
cd ./build_${CHROMA}
cmake ${SRCROOT}/chroma -DCMAKE_CXX_COMPILER=${CXX} \
		-DCMAKE_C_COMPILER=${CC} -DCMAKE_C_STANDARD=99 -DCMAKE_C_EXTENSIONS=OFF  \
	 	-DBUILD_SHARED_LIBS=ON \
		-DCMAKE_BUILD_TYPE=RelWithDebInfo \
		-DQDPXX_DIR=${INSTALLROOT}/${QDP}/lib/cmake/QDPXX \
		-DQMP_DIR=${INSTALLROOT}/${QMP}/lib/cmake/QMP \
        -DLLVM_DIR=${INSTALLROOT}/llvm-15/lib/cmake/llvm \
	    -DChroma_ENABLE_QUDA=${ENABLE_QUDA} \
		-DChroma_ENABLE_OPENMP=ON \
		-DChroma_ENABLE_JIT_CLOVER=${JIT} \
        -DHDF5_ROOT=${INSTALLROOT}/${HDF5}/ \
		-DQUDA_DIR=${INSTALLROOT}/${QUDA}/lib/cmake/QUDA \
		-DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/${CHROMA}

cmake --build . -j 32 -v 
cmake --install .

popd
