#! /bin/bash
# @说明：
# @时间：2020/05/02 13:22:37
shopt -s  expand_aliases
# 要修改的内容: gitee, github
git1_1='https://564733702%40qq.com:dl640107@gitee.com'
git1_name='jojo2019007'
git1_email='56473702@qq.com'

git2_1='https://git564733702:dl640107@github.com'
git2_name='git564733702'
git2_email='56473702@qq.com'

dir_file='/root/.git-credentials'                       # 目标文件
alias cmd1='git config --global credential.helper store' # 修改后执行的命令
alias cmd1_1='cat /root/.git-credentials'
alias cmd1_2='cat /root/.gitconfig'                          # 查看结果
alias set_name='git config --global user.name'
alias set_email='git config --global user.email'


function f_run () {
    echo $1 > $dir_file
    set_name $2
    set_email $3
    cmd1
    cmd1_1
    cmd1_2
}
# f_run $git1_1 $git1_name $git1_email
f_run $git2_1 $git2_name $git2_email

