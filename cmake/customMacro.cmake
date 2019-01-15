# My customs Macro for workspace building/installing/packaging

# list directory in the curdir
macro(SUBDIRLIST result curdir)
      file(GLOB children RELATIVE ${curdir} ${curdir}/*)
      set(dirlist "")
      foreach(child ${children})
      		if(IS_DIRECTORY ${curdir}/${child})
            	list(APPEND dirlist ${child})
            endif()
      endforeach()
      set(${result} ${dirlist})
endmacro()

# build a debian package out of the cmake config with cpack
# a debian.cmake is necessary in your package
macro(BUILDDEB)
    if(EXISTS "${CMAKE_ROOT}/Modules/CPack.cmake")
    include(InstallRequiredSystemLibraries)
    set(CPACK_SET_DESTDIR "on")
    set(CPACK_PACKAGING_INSTALL_PREFIX "/tmp")
    set(CPACK_GENERATOR "DEB")
    set(CPACK_PACKAGE_DESCRIPTION "${DESCRIPTION}")
    set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "${SUMMARY}")
    set(CPACK_PACKAGE_VENDOR "${VENDOR}")
    set(CPACK_PACKAGE_CONTACT "${MAINTAINER}")
    set(CPACK_PACKAGE_VERSION_MAJOR "${MAJOR_VERSION}")
    set(CPACK_PACKAGE_VERSION_MINOR "${MINOR_VERSION}")
    set(CPACK_PACKAGE_VERSION_PATCH "${PATCH_VERSION}")
    set(CPACK_PACKAGE_FILE_NAME "${PROJECT_NAME}_${PKG_VERSION}")
    set(CPACK_SOURCE_PACKAGE_FILE_NAME "${PROJECT_NAME}_${MAJOR_VERSION}.${MINOR_VERSION}.${CPACK_PACKAGE_VERSION_PATCH}")

    set (CPACK_DEBIAN_PACKAGE_SHLIBDEPS ON) # auto detect dependencies
    set( CPACK_OUTPUT_CONFIG_FILE "${PROJECT_BINARY_DIR}/CPackConfig.cmake" )

    set(CPACK_DEBIAN_PACKAGE_PRIORITY "optional")
    set(CPACK_DEBIAN_PACKAGE_SECTION "beuz")
    set(CPACK_DEBIAN_ARCHITECTURE ${CMAKE_SYSTEM_PROCESSOR})
    set(CPACK_ARCHIVE_COMPONENT_INSTALL ON)
    include(CPack)
    ENDIF(EXISTS "${CMAKE_ROOT}/Modules/CPack.cmake")
endmacro()

# transform ARGN to a string of all the args separated by a space
macro(ARGN_TO_STRING)
    set (LIST_ARGN ${ARGN})
    list(GET LIST_ARGN 0 LIST_STRING)
    list(REMOVE_AT LIST_ARGN 0)
    foreach(ELEMENT ${LIST_ARGN})
        set(LIST_STRING "${ELEMENT} ${LIST_STRING}")
    endforeach()
endmacro()

# export all the necessary files in order to use this package from another workspace
# ie: find_package
macro(SETUP_PKG PKG_NAME)
    message("PKG_NAME ${PKG_NAME}")
    message("MODULES ${ARGN}")
    set (TARGETS ${ARGN})
    list(GET TARGETS 0 TARGETS_LIST)
    list(REMOVE_AT TARGETS 0)
    foreach(TARGET ${TARGETS})
        set(TARGETS_LIST "${TARGET} ${TARGETS_LIST}")
    endforeach()
    export(TARGETS ${TARGETS_LIST} FILE "${PROJECT_BINARY_DIR}/${PKG_NAME}.cmake")
    export(PACKAGE ${PKG_NAME})

    include(${CMAKE_CURRENT_SOURCE_DIR}/debian.cmake)
    set(PKG_VERSION ${MAJOR_VERSION}.${MINOR_VERSION}.${PATCH_VERSION})

    set(CONF_INCLUDE_DIRS "${PROJECT_SOURCE_DIR}" "${PROJECT_BINARY_DIR}")
    configure_file(${ROOT_DIR}/cmake/pkg-config.cmake
        "${PROJECT_BINARY_DIR}/${PKG_NAME}Config.cmake" @ONLY)

    set(CONF_INCLUDE_DIRS "${MAKE_INSTALL_PREFIX}/${PROJECT_NAME}")
    configure_file(${ROOT_DIR}/cmake/pkg-config.cmake
        "${PROJECT_BINARY_DIR}/${PKG_NAME}Config.cmake" @ONLY)

    configure_file(${ROOT_DIR}/cmake/ConfigVersion.cmake
        "${PROJECT_BINARY_DIR}/${PKG_NAME}ConfigVersion.cmake" @ONLY)

    install(FILES
        ${PROJECT_BINARY_DIR}/${PKG_NAME}Config.cmake
        ${PROJECT_BINARY_DIR}/${PKG_NAME}ConfigVersion.cmake
        DESTINATION lib/${PROJECT_NAME})
    install(EXPORT ${PKG_NAME} DESTINATION lib/${PROJECT_NAME})

endmacro()

# Custom find_package to avoid to try to reimport a target already present
# (This Macro is just a workaround, need to find a better solution)
macro(FIND_PKG pkg)
    if (NOT TARGET ${pkg})
        find_package(${pkg} REQUIRED)
    endif()
endmacro()

# Macro to install targets
macro(INSTALL_BIN_LIB PKG_NAME)
    ARGN_TO_STRING(${ARGN})
    install (TARGETS ${LIST_STRING}
         EXPORT ${PKG_NAME}
         ARCHIVE DESTINATION lib/${PROJECT_NAME}
         LIBRARY DESTINATION lib/${PROJECT_NAME}
         RUNTIME DESTINATION bin/${PROJECT_NAME})
endmacro()

# Macro to install headers
macro(INSTALL_ALL_HEADERS)
    install(DIRECTORY include/ DESTINATION include)
endmacro()

