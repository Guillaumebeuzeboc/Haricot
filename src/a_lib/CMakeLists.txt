project(a_lib VERSION 0.1 LANGUAGES CXX)

find_package( Boost COMPONENTS date_time REQUIRED )

INIT_PKG()

SETUP_PYTHON_PKG()

include_directories(include ${Boost_INCLUDE_DIR} )
add_library(a_lib
    src/lib.cpp)

target_include_directories(a_lib PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
    PRIVATE src)

# Depend on a library that we defined in the top-level file
target_link_libraries(a_lib ${Boost_LIBRARIES})

INSTALL_BIN_LIB(a_lib a_lib)

INSTALL_ALL_HEADERS()

INSTALL_PYTHON_SCRIPTS(scripts/a_test.py)

SETUP_PKG(a_lib a_lib) # First arg is pkg name and after they are the targets names

BUILDDEB()
