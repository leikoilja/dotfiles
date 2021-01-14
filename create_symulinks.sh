#!/bin/bash
 
# This script creates symlinks from the current GIT dotfiles repo into current
# user's HOME directory to prepare DEV environment using dotfiles settings

# TODO: promt to ask if using ubuntu or mac system

dirname=$PWD
 
# echo "Enter the path to your ExpressionEngine Install without a trailing slash [ENTER]:"
# read ee_path
# echo "Enter your system folder name [ENTER]:"
# read ee_system_folder
#
# # create sym links
# ln -s "$dirname"/system/extensions/ext.lg_data_matrix_ext.php "$ee_path"/"$ee_system_folder"/extensions/ext.lg_data_matrix_ext.php
# ln -s "$dirname"/system/language/english/lang.lg_data_matrix_ext.php "$ee_path"/"$ee_system_folder"/language/english/lang.lg_data_matrix_ext.php
# ln -s "$dirname"/themes/cp_themes/default/lg_data_matrix "$ee_path"/themes/cp_themes/default/lg_data_matrix
#
# # copy global cp images to install
# cp "$dirname"/themes/cp_global_images/* "$ee_path"/themes/cp_global_images
