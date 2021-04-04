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

# Add machine-specific flags
add_definitions(${MACHINE})
add_link_options(${MACHINE})

if (NOT ${VARIANT} STREQUAL "")
  add_definitions(-D${VARIANT})
endif()

# Common flags
add_definitions(
  -ffunction-sections
  -fomit-frame-pointer
  -fno-strict-aliasing
  -fshort-wchar
  )

# Common includes
list (APPEND INCLUDES
  ${XSDK}${BSP}/ps7_cortexa9_0/include
  )
set(CMAKE_C_STANDARD_INCLUDE_DIRECTORIES ${INCLUDES})
set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES ${INCLUDES})

# Linker flags
add_link_options(
  -T ${XSDK}/brd/lscript.ld
  -Wl,--gc-sections
  )

# Libraries
list (APPEND LIBS
  -Wl,--start-group
  -lm
  -Wl,--end-group
  )
list(JOIN LIBS " " LIBS) # Convert list to space separated string
set(CMAKE_C_STANDARD_LIBRARIES ${LIBS})
set(CMAKE_CXX_STANDARD_LIBRARIES "${LIBS} -lstdc++")
