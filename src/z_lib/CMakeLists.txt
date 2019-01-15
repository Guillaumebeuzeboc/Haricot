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
    $<INSTALL_INTERFACE:${EIGEN3_INCLUDE_DIR}>
    PRIVATE src)
# Depend on a library that we defined in the top-level file
target_link_libraries(z_lib ${Boost_LIBRARIES})

install (TARGETS z_lib
         EXPORT z_lib
         ARCHIVE DESTINATION lib/${PROJECT_NAME}
         LIBRARY DESTINATION lib/${PROJECT_NAME}
         RUNTIME DESTINATION bin/${PROJECT_NAME})

INSTALL_ALL_HEADERS()

SETUP_PKG(z_lib z_lib)

BUILDDEB()
