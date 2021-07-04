## 
# @file    create_sdk_workspace.tcl
# @brief   Generate or Create BSP for Xilinx SDK
# @author  
# @date    
# @version 
#
# Script to Create BSP from hdf using xilinx toolchain for working with Xilinx
# SDK

#
# <b>Modification history</b>
# <pre>
# Version Engineer  Date       Change details
# ------- --------  ---------- -----------------------------------------------
# </pre>
##

# include config
source [file join [file dirname [info script]] "config.tcl"]

## @brief Workspace directory passed as argument to tcl script
set work_space $::argv

# set workspace
sdk setws -switch $work_space

# create hardware project from the hardware definition file
sdk createhw -name $hardware_project_name -hwspec $hdf_file

# create FSBL project with own bsp (standalone)
createapp -name $fsbl_project_name -hwproject $hardware_project_name \
 -proc ps7_cortexa9_0 -os standalone -app {Zynq FSBL} -lang C -arch 32
# add defines to teh FSBL project 
# - activate extra debug info 
sdk configapp -app $fsbl_project_name define-compiler-symbols FSBL_DEBUG_INFO

# create application bsp
sdk createbsp -name $app_bsp_project_name -hwproject $hardware_project_name \
 -proc ps7_cortexa9_0 -os standalone
 