project(g_app)
FIND_PKG(a_lib)
FIND_PKG(z_lib)
add_executable(g_app
    src/app.cpp)

# Depend on a library that we defined in the top-level file
target_link_libraries(g_app z_lib a_lib)

BUILDDEB()
