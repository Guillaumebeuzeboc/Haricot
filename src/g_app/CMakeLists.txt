project(g_app)

add_executable(g_app
    src/app.cpp)

# Depend on a library that we defined in the top-level file
target_link_libraries(g_app z_lib a_lib)

BUILDDEB()
