# Haricot
Test of a mutli repo CMake based template
Packages can contains C++ and Python code
Tested only on Linux with cmake 3.13.2 and 3.5.1

## Usage

- `./haricot`
- `cd build/src/mypkg; cpack`
- `cd build; ninja install`
## Features

Top level CMakeLists.txt architecture
The CMakeLists.txt in packages (Subdirectories) are standards (except that they can use extra features)

- Build all the packages (subdiretories)
- Export pkg.cmake in order to includes them in another project/package
- Assign a version number
- Install targets/headers in the install directory at the root of the project
- Generate .deb for each packages

## Create a new workspace

You can create a ws that would use haricot. To do that you would just have to create a symbolic link to the TopLevelCMake.txt the setup_local.zsh and to the haricot cmd (use the repo as an example).
You can even combien workspace.

## Add a package (subdirectory)

Packages can come from different git repo or sub-modules

- The package need to have a `CMakeLists.txt`
- The `CMakeLists.txt` can use commands like:
    - `INIT_PKG` Setup necessary variables for the pkg
    - `SETUP_PYTHON_PKG` Setup for pkg containing Python code (will take care of installing and sourcing your python sources)
    - `INSTALL_BIN_LIB(pkg_name lib1 lib2 bin1 bin2 ...)` install binaries and libraries in the correct directories (For C++ bin/lib)
    - `INSTALL_ALL_HEADERS` Install headers (Useful for  C++ libs)
    - `INSTALL_PYTHON_SCRIPTS` Install  Python scripts
    - `SETUP_PKG(pk_name target1 target2 ...)` setup the configuration of the package so you can use it in another pkg/workspace with `find_package`
    - `BUILDDEB()`  add all the cpack command to build a .deb for the package
- The package also need a `debian.cmake` set cmake variable for the debian pkg:
    - `MAJOR_VERSION`
    - `MINOR_VERSION`
    - `PATCH_VERSION`
    - `DESCRIPTION`
    - `SUMMARY`
    - `VENDOR`
    - `MAINTAINER`
