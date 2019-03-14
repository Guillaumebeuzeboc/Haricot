project(haricot)

INIT_PKG()

SETUP_PKG(haricot)

install(DIRECTORY cmake/ DESTINATION share/haricot/cmake COMPONENT HARICOT)
install(FILES haricot setup_install.zsh setup_local.zsh DESTINATION share/haricot COMPONENT HARICOT)
install(FILES setup.zsh DESTINATION . COMPONENT HARICOT)
BUILDDEB()
