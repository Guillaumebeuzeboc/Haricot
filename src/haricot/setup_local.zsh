MY_SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
CMAKE_PREFIX_PATH=${MY_SCRIPTPATH}/build/src:${CMAKE_PREFIX_PATH}
PYTHONPATH=${MY_SCRIPTPATH}/build/python/lib/python3.5/site-packages:${PYTHONPATH}
