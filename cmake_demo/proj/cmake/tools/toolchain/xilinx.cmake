
#[=======================================================================[.rst:
xilinx sdk toolchain
-------------------

The following environment variables must be set when cmake
configuration is invoked::

  XSDK        - Location of xilinx sdk workspace
  BSP         - Xilinx SDK proj bsp name

The following environment variables are optional::

  COMPILERS     - Compiler search path, defaults to Windows xilinx installation

Your CMAKE_MODULE_PATH must also be configured so that
Platform/xilinx.cmake can be found.

Example to build for the demo_board board::

  XSDK=/path/to/xilinx sdk workspace BSP=xilinx sdk proj bsp name cmake \
     -B build.demo_board \
     -DCMAKE_TOOLCHAIN_FILE=/path_to_this xilinx.cmake toolchain_file
#]=======================================================================]

set(XSDK_INSTALL_PATH "$ENV{XILINX_SDK}" CACHE PATH   "Xilinx SDK installation path." FORCE)
set(XSDK_XSCT "$ENV{XILINX_SDK}/bin/xsct.bat" CACHE PATH   "Xilinx XSCT path."    FORCE)

include_guard()

# The name of the target operating system
set(CMAKE_SYSTEM_NAME xilinx)
SET(CMAKE_SYSTEM_PROCESSOR arm)
# Version of the system
SET(CMAKE_SYSTEM_VERSION 1)

# generate Makefile and Xilinx SDK projects
set(CMAKE_GENERATOR       "Unix Makefiles" CACHE INTERNAL "" FORCE)
set(CMAKE_EXTRA_GENERATOR "Eclipse CDT4"   CACHE INTERNAL "" FORCE)
set(CMAKE_ECLIPSE_VERSION 4.6.1 CACHE PATH "" FORCE)

# Default toolchain search path
if (NOT DEFINED ENV{COMPILERS})
  set(ENV{COMPILERS} "${XSDK_INSTALL_PATH}/gnu/aarch32/nt/gcc-arm-none-eabi/bin/")
endif()

# Default values
if (NOT DEFINED ENV{XSDK})
  set(ENV{XSDK} "C:/workspace/cmake_demo/proj/sdk")
endif()

if (NOT DEFINED ENV{BSP})
  set(ENV{BSP} "cortexa9_0_app_bsp")
endif()

# Get environment variables
set(XSDK $ENV{XSDK} CACHE STRING
  "Location of xilinx sdk tree")
set(BSP $ENV{BSP} CACHE STRING
  "BSP Name")
set(COMPILERS $ENV{COMPILERS} CACHE STRING
  "Location of compiler toolchain")  
  
# inform the user of Xilinx SDK configuration
message(STATUS "Configuring build system using Xilinx SDK.")
if(NOT UNIX)
  set(EXTENSION ".exe" CACHE STRING "Host platform executable file extension.")
endif()

# use Make from Xilinx
set(CMAKE_MAKE_PROGRAM "${XSDK_INSTALL_PATH}/gnuwin/bin/make${EXTENSION}" CACHE PATH "" FORCE)
    
# Create bsp and sdk workspace during configuration and pass build dir argument to tcl
#execute_process(COMMAND ${XSDK_XSCT} ${XSDK}/scripts/create_sdk_workspace.tcl ${XILINX_DEMO_BINARY_DIR}/src)
#execute_process(COMMAND ${XSDK_XSCT} -eval source ${XSDK}/scripts/build_bsp.tcl ${XILINX_DEMO_BINARY_DIR}/src)

# Create bsp and sdk workspace during build and pass build dir argument to tcl
add_custom_target(
  XilinxWorkspaceTarget ALL
  COMMAND ${XSDK_XSCT} ${XSDK}/scripts/create_sdk_workspace.tcl ${XILINX_DEMO_BINARY_DIR}/src
  COMMAND ${XSDK_XSCT} -eval source ${XSDK}/scripts/build_bsp.tcl ${XILINX_DEMO_BINARY_DIR}/src
)

# Check that bsp.mk exists
# set(BSP_MK_FILE ${XSDK}/${BSP}/Makefile)
# if (NOT EXISTS ${BSP_MK_FILE})
  # message(FATAL_ERROR "Failed to open ${BSP_MK_FILE}")
# endif()

# # Slurp BSP Makefile contents
# file(READ ${BSP_MK_FILE} BSP_MK)

# Get PROCESSOR
# string(REGEX MATCH "PROCESSOR=([A-Za-z0-9_\-]*)" _ ${BSP_MK})
# set(PROCESSOR ${CMAKE_MATCH_1} CACHE STRING "")

# Set cross-compiler toolchain
set(CMAKE_C_COMPILER ${COMPILERS}/arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER ${COMPILERS}/arm-none-eabi-g++)
set(CMAKE_ASM-ATT_COMPILER ${COMPILERS}/arm-none-eabi-as)
if(CMAKE_HOST_WIN32)
  set(CMAKE_C_COMPILER ${CMAKE_C_COMPILER}.exe)
  set(CMAKE_CXX_COMPILER ${CMAKE_CXX_COMPILER}.exe)
  set(CMAKE_ASM-ATT_COMPILER ${CMAKE_ASM-ATT_COMPILER}.exe)
endif(CMAKE_HOST_WIN32)

# Set cross-compiler machine-specific flags
include(toolchain/cortex-a9)

