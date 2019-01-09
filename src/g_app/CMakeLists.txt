project(g_app)
if (NOT TARGET a_lib)
    find_package(a_lib)
endif()
add_executable(g_app
    src/app.cpp)

# Depend on a library that we defined in the top-level file
target_link_libraries(g_app z_lib a_lib)

BUILDDEB()
