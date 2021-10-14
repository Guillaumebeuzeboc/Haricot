MY_SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
export CMAKE_PREFIX_PATH=${MY_SCRIPTPATH}/install:${CMAKE_PREFIX_PATH}
export PYTHONPATH=${MY_SCRIPTPATH}/install/lib/python3/dist-packages:${PYTHONPATH}
