#!/bin/bash
echo "flex执行开始！"
flex -o SimpleCal.yy.c SimpleCal.l
echo "bison执行开始！"
bison -o SimpleCal.tab.h SimpleCal.y
echo "gcc编译开始！"
gcc -o SimpleCal SimpleCal.yy.c SimpleCal.tab.* -lfl
echo "删除中间文件..."
rm SimpleCal.yy.c SimpleCal.tab.*
echo "执行生成最终目标文件..."
./SimpleCal
