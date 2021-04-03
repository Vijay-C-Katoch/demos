target_sources(xilinx_cmake_demo
  PRIVATE
  src/helloworld.c
  src/platform.c
  )

target_compile_options(xilinx_cmake_demo
  PRIVATE
  -Wall
  -Wextra
  -Werror
  -Wno-unused-parameter
  )

# if (EXISTS ${XILINX_DEMO_SOURCE_DIR}/src/ports/rt-kernel/mb_${BSP}.c)
  # set(BSP_SOURCE src/ports/rt-kernel/mb_${BSP}.c)
# else()
  # set(BSP_SOURCE src/ports/rt-kernel/mb_bsp.c)
# endif()
