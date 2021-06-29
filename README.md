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
          

Windows (Visual Studio)
-----------------------

 * Start a Visual Studio "Developer command prompt" then:
   * `cd demos\cmake_demo\proj\sdk`
   * `mkdir build`
   * `cd build`
   * `cmake .. -G "NMake Makefiles"`
   * `nmake`

Linux & macOS
--------------
   * `cd demos\cmake_demo\proj\sdk`
   * `mkdir build`
   * `cd build`
   * `cmake ..`
   * `make`
