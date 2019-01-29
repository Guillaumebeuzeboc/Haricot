project(g_app)
find_package(a_lib)
find_package(z_lib)

INIT_PKG()

SETUP_PYTHON_PKG()

add_executable(g_app
    src/app.cpp)

# Depend on a library that we defined in the top-level file
target_link_libraries(g_app z_lib a_lib)

INSTALL_BIN_LIB(g_app g_app)

INSTALL_PYTHON_SCRIPTS(scripts/test.py)

SETUP_PKG(g_app g_app) # First arg is pkg name and after they are the targets names

BUILDDEB()

