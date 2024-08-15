# copyright
# app name
# url

# minimal cmake version needed for new option handling
cmake_minimum_required(VERSION 3.13 FATAL_ERROR)
cmake_policy(SET CMP0003 NEW)

# app is written in C
# supported compilers: gcc, clang
project(mympd
  VERSION 1.0.0
  LANGUAGES C
)

# output binaries in bin directory
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

message("Cmake version: ${CMAKE_VERSION}")
message("Cmake src dir: ${PROJECT_SOURCE_DIR}")
message("Cmake build dir: ${CMAKE_CURRENT_BINARY_DIR}")
message("Cmake build type: ${CMAKE_BUILD_TYPE}")
message("Compiler: ${CMAKE_C_COMPILER_ID} ${CMAKE_C_COMPILER_VERSION}")
message("CMAKE_C_FLAGS: ${CMAKE_C_FLAGS}")
message("CMAKE_EXE_LINKER_FLAGS: ${CMAKE_EXE_LINKER_FLAGS}")
message("Arch: ${CMAKE_C_LIBRARY_ARCHITECTURE}")

# required dependencies
#find_package(Threads REQUIRED)
find_package(OpenSSL REQUIRED)

# check dependencies versions
if(OPENSSL_VERSION VERSION_LESS "1.1.0")
  message(FATAL_ERROR "myapp requires an OpenSSL version greater or equal 1.1.0")
endif()

# optional dependencies

# distributed libraries
add_subdirectory("dist")

# the main mympd target
add_subdirectory("src")

# link all together
target_link_libraries(myapp
  mongoose
  ${CMAKE_THREAD_LIBS_INIT}
  ${OPENSSL_LIBRARIES}  
)

# install
install(TARGETS myapp DESTINATION ${CMAKE_INSTALL_FULL_BINDIR})