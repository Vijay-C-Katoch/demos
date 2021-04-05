

list(APPEND MACHINE
  -mfpu=neon
  -mcpu=cortex-a9
  -mfpu=vfpv3
  -mfloat-abi=hard
  -Wl,-specs=${XSDK}/brd/Xilinx.spec
  )
