#! /bin/bash
# @说明：
# @时间：2020/05/02 13:16:15
shopt -s  expand_aliases

#测试带参数的别名，然后使用这个来，作用一个匿名函数
alias c1='func() { cd $1; ls;}; func'
c1 /opt