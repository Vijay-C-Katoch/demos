set script_file [ dict get [ info frame 0] file]
set tcl_dir [file dirname $script_file]
set sdk_dir $tcl_dir/..

## @brief Boards directory
set board_dir $sdk_dir/brd

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