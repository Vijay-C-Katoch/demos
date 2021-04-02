
#[=======================================================================[.rst:
xilinx sdk toolchain
-------------------

The following environment variables must be set when cmake
configuration is invoked::

  XSDK        - Location of xilinx sdk workspace
  PRJ         - Xilinx SDK proj name

The following environment variables are optional::

  COMPILERS     - Compiler search path, defaults to Windows xilinx installation

Your CMAKE_MODULE_PATH must also be configured so that
Platform/xilinx.cmake can be found.

Example to build for the demo_board board::

  XSDK=/path/to/xilinx sdk workspace PRJ=xilinx sdk proj name cmake \
     -B build.demo_board \
     -DCMAKE_TOOLCHAIN_FILE=/path_to_this xilinx.cmake toolchain file
#]=======================================================================]

set(XSDK_INSTALL_PATH "$ENV{XILINX_SDK}" CACHE PATH   "Xilinx SDK installation path." FORCE)
set(XSDK_WORKSPACE    "NONE" CACHE PATH   "Xilinx SDK workspace path."    FORCE)
set(XSDK_BSP          "NONE" CACHE STRING "Target board support package." FORCE)

include_guard()

# The name of the target operating system
set(CMAKE_SYSTEM_NAME xilinx-standalone)

# Default toolchain search path
if (NOT DEFINED ENV{COMPILERS})
  set(ENV{COMPILERS} "${XSDK_INSTALL_PATH}/gnu/aarch32/nt/gcc-arm-none-eabi/bin/")
endif()

# Get environment variables
set(XSDK $ENV{XSDK} CACHE STRING
  "Location of xilinx sdk tree")
set(COMPILERS $ENV{COMPILERS} CACHE STRING
  "Location of compiler toolchain")
set(PRJ $ENV{PRJ} CACHE STRING
  "Xilinx Project name")
set(BSP ${PRJ}_bsp CACHE STRING
  "The name of the BSP to build for")

# Check that bsp.mk exists
set(BSP_MK_FILE ${XSDK}/${BSP}/Makefile)
if (NOT EXISTS ${BSP_MK_FILE})
  message(FATAL_ERROR "Failed to open ${BSP_MK_FILE}")
endif()

# Slurp BSP Makefile contents
file(READ ${BSP_MK_FILE} BSP_MK)

# Get PROCESSOR
string(REGEX MATCH "PROCESSOR=([A-Za-z0-9_\-]*)" _ ${BSP_MK})
set(PROCESSOR ${CMAKE_MATCH_1} CACHE STRING "")

# Set cross-compiler toolchain
set(CMAKE_C_COMPILER ${COMPILERS}/arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER ${COMPILERS}/arm-none-eabi-g++)
if(CMAKE_HOST_WIN32)
  set(CMAKE_C_COMPILER ${CMAKE_C_COMPILER}.exe)
  set(CMAKE_CXX_COMPILER ${CMAKE_CXX_COMPILER}.exe)
endif(CMAKE_HOST_WIN32)

# Set cross-compiler machine-specific flags
include(toolchain/${PROCESSOR})

