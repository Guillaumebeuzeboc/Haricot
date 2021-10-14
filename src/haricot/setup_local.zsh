USAGE="$(basename "$0"): Source Haricot built packages

where:
        [NAME_OF_BUILD_DIRECTORY]   -- clean build & install directory (build-stm32 for example)
        -h|--help                   -- print this"

BUILD_DIRNAME="build"
while [[ $# -gt 0 ]]
do
    case "$1" in
        -h|--help)
        echo "$USAGE"
        exit 1
	;;
        *)
	BUILD_DIRNAME=$1
        shift
        ;;
    esac
done

MY_SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
export CMAKE_PREFIX_PATH=${MY_SCRIPTPATH}/${BUILD_DIRNAME}/src:${CMAKE_PREFIX_PATH}
export PYTHONPATH=${MY_SCRIPTPATH}/${BUILD_DIRNAME}/python/lib/python3.5/site-packages:${PYTHONPATH}

