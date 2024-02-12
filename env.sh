module load  DefApps-2023
module load cuda/11.5.2
module load cmake
module load gcc/11.2.0
module load ninja
module load openblas/0.3.24-omp


ND=4
QDP_LAYOUT=cb2
JIT=OFF
STACK=-gpu
QDP_SRC=qdpxx
ENABLE_QUDA=ON

if [[ ${1} == *"cpu"* ]]; then
  STACK=-cpu
  ENABLE_QUDA=OFF
fi
if [[ ${1} == *"3D"* ]]; then
   ND=3
   STACK=$STACK-${ND}D
fi
if [[ ${1} == *"jit"* ]]; then
   JIT=ON
   STACK=$STACK-jit
   QDP_SRC=qdp-jit
fi
if [[ ${1} == *"lexico"* ]]; then
  QDP_LAYOUT=lexico
  STACK=${STACK}-lexico
fi
echo "Building stack: ${STACK}"

CHROMA=chroma${STACK}
CHROMA_LAPH=chroma_laph${STACK}
QMP=qmp
QUDA=quda${STACK}
QDP=qdp${STACK}
HDF5=hdf5
CXX=mpicxx
CC=mpicc


export GCC_HOME=${OLCF_GCC_ROOT}
export TOPDIR_HIP=`pwd`
export SRCROOT=${TOPDIR_HIP}/../src
export BUILDROOT=${TOPDIR_HIP}/build
export INSTALLROOT=${TOPDIR_HIP}/install/summit${STACK}
export LD_LIBRARY_PATH=${INSTALLROOT}/llvm-15:${INSTALLROOT}/${HDF5}/lib:${INSTALLROOT}/${CHROMA}/lib:${INSTALLROOT}/${QDP}/lib:${INSTALLROOT}/${QMP}/lib:${LD_LIBRARY_PATH}

export LIBRARY_PATH=${INSTALLROOT}/${HDF5}/include:${LIBRARY_PATH}


export CUDA_HOME=$CUDA_DIR
export MPI_HOME=$MPI_ROOT
