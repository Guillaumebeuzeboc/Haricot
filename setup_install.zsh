MY_SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
CMAKE_PREFIX_PATH=${MY_SCRIPTPATH}/install:${CMAKE_PREFIX_PATH}
