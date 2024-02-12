source ./env.sh ${1}
pushd ${BUILDROOT}

if [ -d ./build_${CHROMA_LAPH} ];
then
  rm -rf ./build_${CHROMA_LAPH}
fi

mkdir  ./build_${CHROMA_LAPH}
cd ./build_${CHROMA_LAPH}


echo -e "I am using:\n    ${CHROMA}\n    ${QDP}\n    ${QUDA}\n    ${HDF5}\n"

cmake ${SRCROOT}/chroma_laph_jit -DBUILD_HDF5=TRUE -DCMAKE_CXX_COMPILER=${CXX} \
                   -DCMAKE_C_COMPILER=${CC} -DCMAKE_CXX_STANDARD=20 \
                   -DCMAKE_C_STANDARD=99 -DCMAKE_C_EXTENSIONS=OFF  \
                   -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/${CHROMA_LAPH} \
                   -DQUDA_DIR=${INSTALLROOT}/${QUDA}/lib/cmake/QUDA \
                   -DQDPXX_DIR=${INSTALLROOT}/${QDP}/lib/cmake/QDPXX \
                   -DHDF5_ROOT=${INSTALLROOT}/${HDF5} \
                   -DQMP_DIR=${INSTALLROOT}/${QMP}/lib/cmake/QMP \
                   -DCMAKE_CXX_FLAGS=" ${MPI_CFLAGS} -DUSE_OPENBLAS -I$OLCF_OPENBLAS_ROOT/include -I${INSTALLROOT}/${HDF5}/include " \
                   -DCMAKE_C_FLAGS=" ${MPI_CFLAGS} -I${INSTALLROOT}/${HDF5}/include " \
                   -DCMAKE_EXE_LINKER_FLAGS="${MPI_LDFLAGS}" \
                   -DCMAKE_SHARED_LINKER_FLAGS="${MPI_LDFLAGS} -L$OLCF_OPENBLAS_ROOT/lib " \
                   -DChroma_DIR=${INSTALLROOT}/${CHROMA}/lib/cmake/Chroma  


cmake --build . -j 32 -v
cmake --install .

popd
