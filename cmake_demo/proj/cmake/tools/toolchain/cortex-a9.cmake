
list(APPEND MACHINE_COMPILER
  -mcpu=cortex-a9
  -mfpu=vfpv3
  -mfloat-abi=hard
  )

list(APPEND MACHINE_LINKER
  -mcpu=cortex-a9
  -mfpu=vfpv3
  -mfloat-abi=hard
  -Wl,-build-id=none
  -specs=${XSDK}/brd/Xilinx.spec
  )
