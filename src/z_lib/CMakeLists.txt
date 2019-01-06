project(z_lib)

find_package( Boost COMPONENTS date_time REQUIRED )
find_package(Eigen3 REQUIRED)
include_directories(include ${Boost_INCLUDE_DIR} ${EIGEN3_INCLUDE_DIR})
add_library(z_lib
    src/lib.cpp)

target_include_directories(z_lib PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<BUILD_INTERFACE:${EIGEN3_INCLUDE_DIR}>
    $<INSTALL_INTERFACE:include>
    PRIVATE src)
# Depend on a library that we defined in the top-level file
target_link_libraries(z_lib ${Boost_LIBRARIES})
