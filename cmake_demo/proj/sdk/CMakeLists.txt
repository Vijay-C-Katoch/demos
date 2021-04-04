cmake_minimum_required(VERSION 3.1)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../cmake/tools")
project(XILINX_DEMO VERSION 0.0.1)

# Set required standard level
set (CMAKE_C_STANDARD 99)
set (CMAKE_CXX_STANDARD 11)

# Default to installing in build directory
if (CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX ${XILINX_DEMO_BINARY_DIR}/install
    CACHE PATH "Default install path" FORCE)
endif()

MESSAGE(STATUS "CMAKE_SYSTEM_NAME is ${CMAKE_SYSTEM_NAME}")
MESSAGE(STATUS "CMAKE_SYSTEM_PROCESSOR is ${CMAKE_SYSTEM_PROCESSOR}")

# Generate version numbers
configure_file (
  version.h.in
  ${XILINX_DEMO_BINARY_DIR}/src/version.h
  )

# Cross compiling do not try to build test program with compiler
set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")

# Add platform-dependent targets early, so they can be configured by
# platform
#add_library(xilinx_cmake_demo "")
add_executable(xilinx_cmake_demo "")

message(STATUS "Now Building for: ${CMAKE_SYSTEM_NAME}")
# Platform configuration
include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/${CMAKE_SYSTEM_NAME}.cmake)
message(STATUS "Platform Configuration done")

# Define headers for this library. PUBLIC headers are used for
# compiling the library, and will be added to consumers' build
# paths. BUILD_INTERFACE refer build tree and used for building 
# project. INSTALL_INTERFACE refers install tree install(EXPORT)
# use things listed in install interface
target_include_directories(xilinx_cmake_demo
  PUBLIC
  $<BUILD_INTERFACE:${XILINX_DEMO_SOURCE_DIR}>/src
  $<BUILD_INTERFACE:${XILINX_DEMO_BINARY_DIR}/include>
  $<INSTALL_INTERFACE:include>
  PRIVATE
  ${XILINX_DEMO_BINARY_DIR}/src
  src
  )

message(STATUS "XILINX_DEMO_SOURCE_DIR Path: ${XILINX_DEMO_SOURCE_DIR}")
message(STATUS "XILINX_DEMO_BINARY_DIR Path: ${XILINX_DEMO_BINARY_DIR}")

# add directory to find sources
add_subdirectory (src)

# this module to search for compiler-provided system runtime libraries 
# and add install rules for them  all library files listed in the variable 
# CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS will be installed with install(PROGRAMS …) 
# into bin for WIN32 and lib for non-WIN32.
include (InstallRequiredSystemLibraries)