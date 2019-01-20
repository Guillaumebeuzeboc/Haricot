project(qplot)

find_package(Qt5Widgets REQUIRED)

qt5_wrap_cpp(QPLOT_HEADERS_MOC include/qplot/qcustomplot.h)

add_library(qplot
    src/qcustomplot.cpp ${QPLOT_HEADERS_MOC})

qt5_use_modules(qplot Widgets)

target_include_directories(qplot PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
    PRIVATE src)

INSTALL_BIN_LIB(qplot qplot)

INSTALL_ALL_HEADERS()

SETUP_PKG(qplot qplot)

BUILDDEB()
