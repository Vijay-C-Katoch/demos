mkdir ..\build
chdir ..\build
cmake.exe -DCMAKE_TOOLCHAIN_FILE=..\cmake\tools\toolchain\xilinx.cmake -G "Eclipse CDT4 - Unix Makefiles" --trace ..\sdk > trace.txt 2>&1
::make install

::cmake.exe -E env XSDK=C:/workspace/cmake_demo/proj/sdk BSP=cortexa9_0_app_bsp cmake.exe -DCMAKE_TOOLCHAIN_FILE=..\cmake\tools\toolchain\xilinx.cmake --trace ..\sdk > trace.txt 2>&1
::cmake.exe --trace ..\sdk > trace.txt 2>&1
