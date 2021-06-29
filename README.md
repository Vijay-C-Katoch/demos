# demos
 cross compile Xilinx sdk project

BUILDING
========


Prerequisites
-------------------------------

 * CMake 2.8.0 or later
 * The following OS environment variables must be assigned :

        * XILINX_SDK    - Location of xilinx sdk installation on host PC  e.g.  
                          XILINX_SDK=C:\Xilinx\SDK\2019.1
          

Windows
--------------
   * run batchfile `run_cmake.bat` at `demos\cmake_demo\proj\sdk`
   * Above batchfile has instructions to cross-compile xilinx target using cmake
   * build artifacts generated at `demos\cmake_demo\proj`
