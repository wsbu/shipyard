set(CMAKE_SYSTEM_NAME Linux)

set(CMAKE_C_COMPILER   "${CMAKE_CURRENT_SOURCE_DIR}/linaro-4.9.4/bin/arm-linux-gnueabihf-gcc")
set(CMAKE_CXX_COMPILER "${CMAKE_CURRENT_SOURCE_DIR}/linaro-4.9.4/bin/arm-linux-gnueabihf-g++")

list(APPEND CMAKE_FIND_ROOT_PATH "${CMAKE_CURRENT_SOURCE_DIR}/linaro-4.9.4/arm-linux-gnueabihf")
