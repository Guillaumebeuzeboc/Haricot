cmake_minimum_required(VERSION 3.5)
project(workspace)

set(cmd "dirname -z $(realpath CMakeLists.txt)")
execute_process(COMMAND bash -c ${cmd}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    RESULT_VARIABLE result
    OUTPUT_VARIABLE ORIGIN)

include(${ORIGIN}/cmake/customMacro.cmake)
include(${ORIGIN}/cmake/python.cmake)
set(ROOT_DIR "${CMAKE_SOURCE_DIR}")
set(CMAKE_INSTALL_PREFIX "${ROOT_DIR}/install")
file(MAKE_DIRECTORY ${CMAKE_INSTALL_PREFIX})

PREPARE_PYTHON()

SUBDIRLIST(SUBDIRS ${CMAKE_CURRENT_SOURCE_DIR}/src)
SORT_SUBDIRS()
FOREACH(subdir ${SUBDIRS})
  message("== Configuration of ${subdir} started")
  ADD_SUBDIRECTORY(src/${subdir})
  message("== Configuration of ${subdir} finished!")
ENDFOREACH()

