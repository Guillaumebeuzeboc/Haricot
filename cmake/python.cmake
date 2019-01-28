
macro(PREPARE_PYTHON)
    set(CMAKE_PYTHON_BUILD "${ROOT_DIR}/build/python/lib/python3.5/site-packages")
    #set(CMAKE_PYTHON_INSTALL "${ROOT_DIR}/install/lib/python3.5/site-packages")
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

     #install(CODE "
     #set(cmd \"PYTHONPATH=${CMAKE_PYTHON_INSTALL}:$ENV{PYTHONPATH} && /usr/bin/python3 setup.py build -b ${ROOT_DIR}/build/${PROJECT_NAME} install --install-layout=deb --prefix=${ROOT_DIR}/install\")
     #       execute_process(COMMAND bash -c \${cmd}
     #                       WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
     #                       OUTPUT_VARIABLE output
     #                       RESULT_VARIABLE result)
     #       message(\"\${output}!!!\")
     #              "
     #       ) #"
     install(CODE "
     set(PATH_TO_PY_FILES \"${CMAKE_PYTHON_INSTALL}/${PROJECT_NAME}\")
        set(cmd \"mkdir -p \${PATH_TO_PY_FILES} &&
            cp ${PROJECT_SOURCE_DIR}/src/${PROJECT_NAME}/*.py \${PATH_TO_PY_FILES} &&
            touch \${PATH_TO_PY_FILES}/__init__.py\")
        execute_process(COMMAND bash -c \${cmd}
                        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
                        OUTPUT_VARIABLE output
                        RESULT_VARIABLE result)
        message(\"!!!!!!!!!!!!!!!!!!! ${PROJECT_SOURCE_DIR}/src/${PROJECT_NAME}/   \")
        message(\"\${output}!!!\")
            ") #"

endmacro()

macro(INSTALL_PYTHON_FILES)
    #install(
    #PROGRAMS
    # scripts/my_scrip.py
    #DESTINATION
    #${CAMKE_PYTHON_INSTALL}/${PROJECT_NAME}
    #)
endmacro()

