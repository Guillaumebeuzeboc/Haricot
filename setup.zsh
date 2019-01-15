MY_SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
CMAKE_PREFIX_PATH=${MY_SCRIPTPATH}/build:${CMAKE_PREFIX_PATH}
