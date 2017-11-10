set(CMAKE_SYSTEM_NAME Linux)

set(CMAKE_C_COMPILER   "$ENV{WSBU_TOOLCHAIN_PATH}/bin/arm-linux-gnueabihf-gcc")
set(CMAKE_CXX_COMPILER "$ENV{WSBU_TOOLCHAIN_PATH}/bin/arm-linux-gnueabihf-g++")

list(APPEND CMAKE_FIND_ROOT_PATH "$ENV{WSBU_TOOLCHAIN_PATH}/arm-linux-gnueabihf")
