project(cmake_multi_repo)

INIT_PKG()

SETUP_PKG(cmake_multi_repo)

install(DIRECTORY cmake/ DESTINATION share/cmake_multi_repo/cmake COMPONENT CMAKE_MULTI_REPO)
install(FILES configure setup_install.zsh setup_package.zsh DESTINATION share/cmake_multi_repo COMPONENT CMAKE_MULTI_REPO)
install(FILES setup.zsh DESTINATION . COMPONENT CMAKE_MULTI_REPO)
BUILDDEB()
