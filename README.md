# cmake_multi_repo_template
test of a mutli repo Cmake based template

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
- Install targets/headers
- Generate .deb for each packages
