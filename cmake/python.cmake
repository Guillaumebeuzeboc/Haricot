
macro(PREPARE_PYTHON)
    set(CMAKE_PYTHON_BUILD "${ROOT_DIR}/build/python/lib/python3.5/site-packages")
    set(CMAKE_PYTHON_INSTALL "${ROOT_DIR}/install/lib/python3.5/site-packages")
    file(MAKE_DIRECTORY ${CMAKE_PYTHON_BUILD})
    file(MAKE_DIRECTORY ${CMAKE_PYTHON_INSTALL})
endmacro()


macro(SETUP_PYTHON_PKG)
     set(ENV{PYTHONPATH} "$ENV{PYTHONPATH}:${CMAKE_PYTHON_BUILD}")
     file(MAKE_DIRECTORY ${CMAKE_PYTHON_BUILD}/${PROJECT_NAME})
     set(INIT_PKG_BUILD ${CMAKE_PYTHON_BUILD}/${PROJECT_NAME}/__init__.py)
     set(PYTHON_SOURCE_PATH "${PROJECT_SOURCE_DIR}/src")
     configure_file(${ROOT_DIR}/cmake/__init__.py.in ${INIT_PKG_BUILD})

     install(CODE "
            set(cmd \"PYTHONPATH=${CMAKE_PYTHON_INSTALL}:$ENV{PYTHONPATH} && /usr/bin/python3 ${PROJECT_SOURCE_DIR}/setup.py install --prefix=${ROOT_DIR}/install\")
            execute_process(COMMAND bash -c \${cmd1}
                            WORKING_DIRECTORY ${ROOT_DIR}/install
                            OUTPUT_VARIABLE output
                            RESULT_VARIABLE result)
            message(\"\${output}!!!\")
                   "
            ) #"

endmacro()

macro(INSTALL_PYTHON_FILES)
    #install(
    #PROGRAMS
    # scripts/my_scrip.py
    #DESTINATION
    #${CAMKE_PYTHON_INSTALL}/${PROJECT_NAME}
    #)
endmacro()

