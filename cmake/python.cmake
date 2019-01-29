
macro(PREPARE_PYTHON)
    set(CMAKE_PYTHON_BUILD "${ROOT_DIR}/build/python/lib/python3.5/site-packages")
    set(CMAKE_PYTHON_INSTALL "${ROOT_DIR}/install/lib/python3/dist-packages")
    file(MAKE_DIRECTORY ${CMAKE_PYTHON_BUILD})
    file(MAKE_DIRECTORY ${CMAKE_PYTHON_INSTALL})
endmacro()


macro(SETUP_PYTHON_PKG)
     set(ENV{PYTHONPATH} "$ENV{PYTHONPATH}:${CMAKE_PYTHON_BUILD}")
     file(MAKE_DIRECTORY ${CMAKE_PYTHON_BUILD}/${PROJECT_NAME})
     set(INIT_PKG_BUILD ${CMAKE_PYTHON_BUILD}/${PROJECT_NAME}/__init__.py)
     set(PYTHON_SOURCE_PATH "${PROJECT_SOURCE_DIR}/src")
     configure_file(${ROOT_DIR}/cmake/__init__.py.in ${INIT_PKG_BUILD})

     set(PATH_TO_${PROJECT_NAME}_PY_FILES "${PROJECT_SOURCE_DIR}/src/${PROJECT_NAME}")
     install(DIRECTORY ${PATH_TO_${PROJECT_NAME}_PY_FILES} DESTINATION lib/python3/dist-packages COMPONENT ${${PROJECT_NAME}_UPPER})

endmacro()

macro(INSTALL_PYTHON_SCRIPTS)
    set (SCRIPTS ${ARGN})
    install(PROGRAMS ${SCRIPTS} DESTINATION lib/${PROJECT_NAME} COMPONENT ${${PROJECT_NAME}_UPPER}
    )
endmacro()

