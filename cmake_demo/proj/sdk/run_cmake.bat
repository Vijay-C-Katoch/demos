mkdir ..\build
chdir ..\build
cmake.exe -DCMAKE_TOOLCHAIN_FILE=..\cmake\tools\toolchain\xilinx.cmake -G "Eclipse CDT4 - Unix Makefiles" --trace ..\sdk > trace.txt 2>&1
::%XILINX_SDK%\gnuwin\bin\make
%XILINX_SDK%\gnuwin\bin\make install
