mkdir ..\build
cmake.exe -DCMAKE_TOOLCHAIN_FILE=..\cmake\tools\toolchain\xilinx.cmake -G "Eclipse CDT4 - Unix Makefiles" --trace -H..\sdk -B..\build > ..\build\trace.txt 2>&1
cmake --build ..\build

::%XILINX_SDK%\gnuwin\bin\make
::%XILINX_SDK%\gnuwin\bin\make install
