
# NOTE: add headers to make them show up in an IDE
target_sources (xilinx_cmake_demo PRIVATE
  ${XILINX_DEMO_SOURCE_DIR}/src/platform.h
  ${XILINX_DEMO_SOURCE_DIR}/src/platform_config.h
  ${XILINX_DEMO_SOURCE_DIR}/src/helloworld.c
  ${XILINX_DEMO_SOURCE_DIR}/src/platform.c
  )

# target_sources (xilinx_cmake_demo PRIVATE
  # ${XILINX_DEMO_SOURCE_DIR}/include/other_includes.h
  # ${XILINX_DEMO_SOURCE_DIR}/include/platform_other.h
  # )