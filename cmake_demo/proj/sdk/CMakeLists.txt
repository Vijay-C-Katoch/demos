cmake_minimum_required(VERSION 3.1)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../cmake/tools")
project(XILINX_DEMO VERSION 0.0.1)

set(CMAKE_CXX_STANDARD 14)

# Default to installing in build directory
if (CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX ${XILINX_DEMO_BINARY_DIR}/install
    CACHE PATH "Default install path" FORCE)
endif()

# Generate version numbers
configure_file (
  version.h.in
  ${XILINX_DEMO_BINARY_DIR}/src/version.h
  )

# Add platform-dependent targets early, so they can be configured by
# platform
add_library(ToDo "")
add_executable(xilinx_cmake_demo "")

# Platform configuration
include(${CMAKE_SYSTEM_NAME})
message (STATUS "Building for ${CMAKE_SYSTEM_NAME}")

# Define headers for this library. PUBLIC headers are used for
# compiling the library, and will be added to consumers' build
# paths. BUILD_INTERFACE refer build tree and used for building 
# project. INSTALL_INTERFACE refers install tree install(EXPORT)
# use things listed in install interface
target_include_directories(xilinx_cmake_demo
  PUBLIC
  $<BUILD_INTERFACE:${XILINX_DEMO_SOURCE_DIR}/include>
  $<BUILD_INTERFACE:${XILINX_DEMO_BINARY_DIR}/include>
  $<INSTALL_INTERFACE:include>
  PRIVATE
  ${XILINX_DEMO_BINARY_DIR}/src
  src
  )

# this module to search for compiler-provided system runtime libraries 
# and add install rules for them  all library files listed in the variable 
# CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS will be installed with install(PROGRAMS …) 
# into bin for WIN32 and lib for non-WIN32.
include (InstallRequiredSystemLibraries)