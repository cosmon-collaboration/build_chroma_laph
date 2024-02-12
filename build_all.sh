source ./env.sh ${1}

: <<COMMENT
 Build chroma_laph stacks from scratch after running get_srcs.sh to get the source codes
 run as:
  ./build_all.sh $ARGS
Default options for no args are:
 Dimensions 4, gpu, checkerboard layout, qdpxx, QUDA

Default: with no args uses QUDA/qdpxx/checkerboard layout and will build a gpu stack

Other set ups can be enable adding -option to the args. These are other options:
 cpu,lexico layout,jit,3D

Args for some combinations are:
 lexico-jit:          gpu/QUDA/qdp-jit/4D/lexico layout
        jit:          gpu/QUDA/qdp-jit/4D/checkerboard layout
     3D-jit:          gpu/QUDA/qdp-jit/3D/checkerboard layout
        cpu:          cpu/QUDA/qdp-jit/4D/qdpxx/checkerboard layout
 lexico-cpu:          cpu/QUDA/qdp-jit/4D/qdpxx/lexico layout
 3D-lexico-cpu:       cpu/QUDA/qdp-jit/3D/qdpxx/lexico layout

COMMENT

if [ ! -d $BUILDROOT ]
then
    mkdir -p $BUILDROOT
fi

./build_qmp.sh ${1}
./build_hdf5.sh ${1}
if [[ ${1} == *"jit"* ]]; then
  ./build_llvm-15.sh ${1}
fi

./build_qdpxx.sh ${1}

if [[ ${1} == *"cpu"* ]]; then
  echo "Building without QUDA"
else
  ./build_quda.sh ${1}
fi


./build_chroma.sh ${1}
./build_chroma_laph.sh ${1}


