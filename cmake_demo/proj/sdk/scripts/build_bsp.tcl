## 
# @file    build_bsp.tcl
# @brief   Script to build Xilinx BSP
# @author  
# @date    
# @version 
#
# Script to build Xilinx SDK generated BSP based on hdf

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

# import projects from source directory to workspace in build 
#importprojects ${sdk_dir}/src/app

# clean the whole workspace
#projects -clean

# regenerate the bsp
# regenbsp -bsp ${work_space}/${app_bsp_project_name}

projects -build -name ${fsbl_project_name}_bsp -type bsp
projects -build -name $fsbl_project_name -type app
projects -build -name $app_bsp_project_name -type bsp
