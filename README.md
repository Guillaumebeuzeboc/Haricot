# cmake_multi_repo_template
Test of a mutli repo Cmake based template

## Usage

cd build/

cmake ../src/

make

make install

cd build/a_lib/; cpack

## Features

Top level CMakeLists.txt architecture
The CmakeLists.txt in packages (Subdirectories) are standards (except that they can use extra features)

- Build all the packages (subdiretories)
- Export pkg.cmake in order to includes them in another project/package
- Assign a version number
- Install targets/headers in the install directory at the root of the project
- Generate .deb for each packages


## add a package (subdirectory)

Packages can come from different git repo or sub-modules

- The package need to have a `CMakeLists.txt`
- The `CMakeLists.txt` can use commands like:
    - `INSTALL_BIN_LIB(pkg_name lib1 lib2 bin1 bin2 ...)` install binaries and libraries in the correct directories
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
