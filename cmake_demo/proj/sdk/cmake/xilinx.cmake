target_compile_options(xilinx_cmake_demo
  PRIVATE
  -Wall
  -Wextra
  -Werror
  -Wno-unused-parameter
  )

# BSP is generated in build directory
# check if generated

if (EXISTS ${XILINX_DEMO_BINARY_DIR}/src/${BSP}/Makefile)
  set(BSP_HEADER_DIR ${XILINX_DEMO_BINARY_DIR}/src/${BSP}/)
else()
  message(STATUS "Error: Application BSP not found at ${XILINX_DEMO_BINARY_DIR}/src/${BSP}")
endif()
