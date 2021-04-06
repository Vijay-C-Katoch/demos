# Get environment variables
set(XSDK_BIN "$ENV{XILINX_SDK}/gnu/aarch32/nt/gcc-arm-none-eabi/bin" CACHE STRING
  "Location of xilinx sdk binaries")

# add_custom_command(
  # TARGET xilinx_cmake_demo
  # POST_BUILD
  # EchoString "Invoking: ARM v7 Print Size"
  # COMMAND ${XSDK_BIN}/arm-none-eabi-size 
# )