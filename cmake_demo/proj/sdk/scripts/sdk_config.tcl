## 
# @file    sdk_config.tcl
# @brief   Script to configure XIlinx SDK
# @author  
# @date    
# @version 
#
# Script to configyre Xilinx SDK e.g import projects

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
importprojects ${sdk_dir}/src/app

# clean the whole workspace
#projects -clean

# regenerate the bsp
# regenbsp -bsp ${work_space}/${app_bsp_project_name}

