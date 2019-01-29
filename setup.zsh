MY_SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
CMAKE_PREFIX_PATH=${MY_SCRIPTPATH}/build:${CMAKE_PREFIX_PATH}
PYTHONPATH=/home/beuzeboc/code/tmp/cmake_multi_repo_template/build/python/lib/python3.5/site-packages:${PYTHONPATH}
