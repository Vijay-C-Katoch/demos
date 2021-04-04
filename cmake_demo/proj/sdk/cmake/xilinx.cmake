# BSP is generated in build directory
# check if generated

if (EXISTS ${XILINX_DEMO_BINARY_DIR}/src/${BSP}/Makefile)
  set(BSP_DIR ${XILINX_DEMO_BINARY_DIR}/src/${BSP})
else()
  message(STATUS "Error: Application BSP not found at ${XILINX_DEMO_BINARY_DIR}/src/${BSP}")
endif()

target_include_directories(xilinx_cmake_demo
  PUBLIC
  ${BSP_DIR}/ps7_cortexa9_0/include
  )
  
target_compile_options(xilinx_cmake_demo
  PRIVATE
  -Wall
  -Wextra
  -Werror
  -Wno-unused-parameter
  )

target_link_libraries(xilinx_cmake_demo

  )
  
  