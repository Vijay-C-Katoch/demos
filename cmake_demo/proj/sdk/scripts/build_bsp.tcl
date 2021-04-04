# include config
source [file join [file dirname [info script]] "config.tcl"]

## @brief Workspace directory passed as argument to tcl script
set work_space $::argv

# set workspace
sdk setws -switch $work_space

# clean the whole workspace
#projects -clean

# regenerate the bsp
# regenbsp -bsp ${work_space}/${app_bsp_project_name}

projects -build -name ${fsbl_project_name}_bsp -type bsp
projects -build -name $fsbl_project_name -type app
projects -build -name $app_bsp_project_name -type bsp