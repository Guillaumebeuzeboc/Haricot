project(qplot_test)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(Qt5Widgets REQUIRED)
find_package(Qt5PrintSupport REQUIRED)
find_package(qplot REQUIRED)


qt5_wrap_ui(UI_HEADERS ressources/mainwindow.ui)

qt5_wrap_cpp(QPLOT_TEST_HEADERS_MOC include/qplot_test/mainwindow.h)

add_executable(qplot_test
    src/main.cpp src/mainwindow.cpp ${UI_HEADERS} ${QPLOT_TEST_HEADERS_MOC})

target_include_directories(qplot_test PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
    PRIVATE src)

# Depend on a library that we defined in the top-level file
target_link_libraries(qplot_test qplot Qt5::Widgets Qt5::PrintSupport)

INSTALL_BIN_LIB(qplot_test qplot_test)

INSTALL_ALL_HEADERS()

SETUP_PKG(qplot_test qplot_test)

BUILDDEB()
