include_guard()
cmake_minimum_required (VERSION 3.1.2)

# Avoid warning when re-running cmake
set(DUMMY ${CMAKE_TOOLCHAIN_FILE})

# No support for shared libs
set_property(GLOBAL PROPERTY TARGET_SUPPORTS_SHARED_LIBS FALSE)

set(UNIX 1)
set(CMAKE_STATIC_LIBRARY_PREFIX "lib")
set(CMAKE_STATIC_LIBRARY_SUFFIX ".a")
set(CMAKE_EXECUTABLE_SUFFIX ".elf")

# Do not build executables during configuration stage. Required
# libraries may not be built yet.
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Prefer standard extensions
set(CMAKE_C_OUTPUT_EXTENSION_REPLACE 1)
set(CMAKE_CXX_OUTPUT_EXTENSION_REPLACE 1)
set(CMAKE_ASM_OUTPUT_EXTENSION_REPLACE 1)

# Add machine-specific flags for compiler and linker
add_compile_options(${MACHINE}) 
add_link_options(${MACHINE})

if (NOT ${VARIANT} STREQUAL "")
  add_definitions(-D${VARIANT})
endif()

# BSP is generated in build directory
# check if generated
if (EXISTS ${XILINX_DEMO_BINARY_DIR}/src/${BSP}/Makefile)
  set(BSP_DIR ${XILINX_DEMO_BINARY_DIR}/src/${BSP})
else()
  message(WARNING "BSP not found at Path: ${XILINX_DEMO_BINARY_DIR}/src/${BSP}")
  message(WARNING "BSP Path is set to default. Please build BSP as custom target before")
  set(BSP_DIR ${XILINX_DEMO_BINARY_DIR}/src/${BSP})
endif()

# Common flags
# add_definitions(
  # -ffunction-sections
  # -fomit-frame-pointer
  # -fno-strict-aliasing
  # -fshort-wchar
  # )

message(STATUS "Platform Path: ${BSP_DIR}/ps7_cortexa9_0/include")  

include_directories(${BSP_DIR}/ps7_cortexa9_0/include)
link_directories(${BSP_DIR}/ps7_cortexa9_0/lib)

# Common includes
list (APPEND INCLUDES
  ${BSP_DIR}/ps7_cortexa9_0/include
  )
 
#cross compiling include dirs 
set(CMAKE_ASM_STANDARD_INCLUDE_DIRECTORIES ${INCLUDES})
set(CMAKE_C_STANDARD_INCLUDE_DIRECTORIES ${INCLUDES})
set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES ${INCLUDES})
  
# Linker flags
add_link_options(
  -T ${XSDK}/brd/lscript.ld
  -Wl,-build-id=none
  -specs=${XSDK}/brd/Xilinx.spec
  )

# Libraries
list (APPEND LIBS
  -Wl,--start-group
  -lxil
  -lgcc
  -lc
  -Wl,--end-group
  )
list(JOIN LIBS " " LIBS) # Convert list to space separated string
# define the standard link libraries
set(CMAKE_C_STANDARD_LIBRARIES ${LIBS})
set(CMAKE_CXX_STANDARD_LIBRARIES "${LIBS} -lstdc++")

# Group libraries when linking

set(CMAKE_C_LINK_EXECUTABLE "<CMAKE_C_COMPILER> <FLAGS> <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> -Wl,--start-group <LINK_LIBRARIES> -Wl,--end-group")

set(CMAKE_CXX_LINK_EXECUTABLE "<CMAKE_CXX_COMPILER> <FLAGS> <CMAKE_CXX_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> -Wl,--start-group <LINK_LIBRARIES> -Wl,--end-group")
