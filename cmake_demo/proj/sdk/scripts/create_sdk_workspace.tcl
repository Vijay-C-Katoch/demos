
set script_file [ dict get [ info frame 0] file]
set tcl_dir [file dirname $script_file]

## @brief Boards directory
set boards_dir $sdk_dir/brd

## @brief Hardware definition file from the Vivado
set hdf_file $board_dir/katbot.hdf

## @brief Hardware project name
set hardware_project_name katbot_hardware_platform

#-----------------------------------------------------------------------------
# fsbl specification

## @brief First stage boot loader project name
set fsbl_project_name cortexa9_0_fsbl

#-----------------------------------------------------------------------------
# app specification

## @brief Aplication bsp project nnme
set app_bsp_project_name cortexa9_0_app_bsp

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
 