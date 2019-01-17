cmake_minimum_required(VERSION 3.5)
project(workspace)

include(../cmake/customMacro.cmake)
set(ROOT_DIR "${CMAKE_SOURCE_DIR}/..")
set(CMAKE_INSTALL_PREFIX "${ROOT_DIR}/install")
file(MAKE_DIRECTORY ${CMAKE_INSTALL_PREFIX})

SUBDIRLIST(SUBDIRS ${CMAKE_CURRENT_SOURCE_DIR})
SORT_SUBDIRS()
FOREACH(subdir ${SUBDIRS})
  message("== Configuration of ${subdir} started")
  ADD_SUBDIRECTORY(${subdir})
  message("== Configuration of ${subdir} finished!")
ENDFOREACH()

