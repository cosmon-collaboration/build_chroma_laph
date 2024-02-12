source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_${QDP} ];
then
  rm -rf ./build_${QDP}
fi

mkdir  ./build_${QDP}
cd ./build_${QDP}
cmake ${SRCROOT}/${QDP_SRC} -DQDP_PARALLEL_ARCH=parscalar \
       -DQDP_PRECISION=double \
       -DCMAKE_BUILD_TYPE=RelWithDebInfo \
       -DBUILD_SHARED_LIBS=ON \
       -DCMAKE_CXX_COMPILER=${CXX} -DCMAKE_CXX_EXTENSIONS=OFF \
       -DCMAKE_C_COMPILER=${CC} -DCMAKE_C_STANDARD=99 -DCMAKE_C_EXTENSIONS=OFF \
       -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/${QDP} \
       -DQMP_DIR=${INSTALLROOT}/${QMP}/lib/cmake/QMP \
       -DQDP_LAYOUT=${QDP_LAYOUT} \
       -DQDP_ENABLE_BACKEND=CUDA \
       -DQDP_BUILD_EXAMPLES=OFF \
       -DQDP_ENABLE_COMM_SPLIT_DEVICEINIT=ON \
       -DHDF5_ROOT=${INSTALLROOT}/${HDF5}/ \
       -DQDP_ND=${ND} \
       -DQDP_USE_HDF5=ON \
       -DQDP_PROP_OPT=ON


cmake --build . -j 32  -v
cmake --install .

popd
