project(a_lib VERSION 0.1 LANGUAGES CXX)

find_package( Boost COMPONENTS date_time REQUIRED )
include_directories(include ${Boost_INCLUDE_DIR} )
add_library(a_lib
    src/lib.cpp)

target_include_directories(a_lib PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
    PRIVATE src)

# Depend on a library that we defined in the top-level file
target_link_libraries(a_lib ${Boost_LIBRARIES})
#export(TARGETS a_lib FILE ALibConfig.cmake)

install (TARGETS a_lib
         EXPORT a_lib
         ARCHIVE DESTINATION lib/${PROJECT_NAME}
         LIBRARY DESTINATION lib/${PROJECT_NAME}
         RUNTIME DESTINATION bin/${PROJECT_NAME})

SETUP_PKG(a_lib a_lib) # First arg is pkg name and after they are the targets names

BUILDDEB()
