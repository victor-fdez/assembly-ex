#!/bin/sh

file_name=${1%.s}
file_name_o="${file_name}.o"
as -g -o $file_name_o $1
ld -o $file_name $file_name_o
