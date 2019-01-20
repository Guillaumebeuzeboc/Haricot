# My customs Macro for workspace building/installing/packaging

# Sort subdirectories to compile dependencies first
macro(SORT_SUBDIRS)
    message("== Before sorting dependencies subdirs: ${SUBDIRS}")
    foreach(dir ${SUBDIRS})
        set(cmd "grep -r \"find_package(${dir})\" | awk -F \"/\" '{print $1}'")
        execute_process(COMMAND bash -c ${cmd}
            WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
            RESULT_VARIABLE result
            OUTPUT_VARIABLE output)
        if(output)
            string(REGEX MATCHALL "[^\n]+" output_list ${output})
            message("the pkg: ${dir} is used in: ${output_list}")
            list(FIND SUBDIRS ${dir} index_dir)
            foreach(usedby ${output_list})
                list(FIND SUBDIRS ${usedby} index_dep)
                if(${index_dep} LESS ${index_dir})
                    message("The using pkg: ${usedby} is located index: ${index_dep} and will be moved to ${index_dir}")
                    list(REMOVE_AT SUBDIRS ${index_dep})
                    list(INSERT SUBDIRS ${index_dir} ${usedby})
                endif()
            endforeach()
            unset(output_list)
        endif()
    endforeach()
    message("== After sorting dependencies subdirs: ${SUBDIRS}")
endmacro()

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

    set(CPACK_DEBIAN_PACKAGE_SHLIBDEPS ON) # auto detect dependencies
    #set(CPACK_DEBIAN_PACKAGE_DEPENDS "${${PROJECT_NAME}_internal_depends}")
    set(CPACK_OUTPUT_CONFIG_FILE "${PROJECT_BINARY_DIR}/CPackConfig.cmake" )

    set(CPACK_DEBIAN_PACKAGE_PRIORITY "optional")
    set(CPACK_DEBIAN_PACKAGE_SECTION "beuz")
    set(CPACK_DEBIAN_ARCHITECTURE ${CMAKE_SYSTEM_PROCESSOR})
    #set(CPACK_ARCHIVE_COMPONENT_INSTALL ON)
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
    set(${PKG_NAME}_VERSION "${PKG_VERSION}" PARENT_SCOPE)

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
macro(find_package)
    if(NOT "${ARGV0}" IN_LIST SUBDIRS)
        _find_package(${ARGV})
    else()
        set(internal_depend ${ARGV0})
        if(DEFINED ${ARGV0}_VERSION)
            set(internal_depend "${internal_depend} (>= ${${internal_depend}_VERSION})")
        endif()
        if(NOT DEFINED ${PROJECT_NAME}_internal_depends)
            set(${PROJECT_NAME}_internal_depends "${internal_depend}")
        else()
            set(${PROJECT_NAME}_internal_depends "${${PROJECT_NAME}_internal_depends}, ${internal_depend}")
        endif()
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

