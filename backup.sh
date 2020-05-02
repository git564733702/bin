#! /bin/bash
# anki用户名, 备份数量上限, 用户数据所在目录, 备份目录,
target='test'
set_count=5
dir_target='/opt/anki/collections/'${target}
dir_backup='/mnt/f/__Desktop/z__Backup/anki/'

set_count=`expr ${set_count} - 1`

# 获取最后一个备份包的更新数据
array01=(`ls ${dir_backup}`)  # 获取一组备份文件
count=${#array01[@]}         # 获取文件数量
count_1=`expr ${count} - 1`  # 获取最后一个文件的index
file_last=${array01[count_1]}  # 获取最后一个文件
lastPkg_time=`stat -c %Y ${dir_backup}${file_last}`  # 获取最后一个文件的更新时间

userPkg_time=`stat -c %Y ${dir_target}` # 获取用户数据的更新时间

echo $userPkg_time --$target
echo $lastPkg_time --$file_last

# 执行压缩
function f_backup () {
	# 1.生成文件名（压缩包）
	time01=$(date +%Y%m%d_%H%M%S)
	zip_name=${target}'Backup_'${time01}'.tgz'
	# 3. 执行压缩, 并指定目录
	tar -czf ${zip_name} $dir_target
	mv $zip_name $dir_backup
	echo tar -czPf ${zip_name} $dir_target
	echo mv $zip_name $dir_backup
	echo "backup done."
}
# 流程控制，是否删除文件
function f_rm () {
	echo $count
	if [ $count -gt $set_count ];then
		echo '文件数量 大于 设置数量，删除第一个'
		echo rm -f ${dir_backup}${array01[0]}
		rm -f ${dir_backup}${array01[0]}
	else
		echo '文件数量不超过'${set_count}'个，不删除'
	fi
}

# 判断用户目录是否有更新
if [ $userPkg_time -gt $lastPkg_time ];then
    echo '用户目录有改动，执行备份操作'
	f_backup
	count=`expr $count + 1`
	f_rm
else
    echo '用户目录没有修改，不执行备份操作'
fi
# -----------------------------------
# 测试：
# 1. 没有更新，不执行备份操作
# 2. 有更新，执行备份操作
# 	2.1 更新后文件数量大于5 --- 删除
#   2.2 更新后文件数量等于5 --- 不删除
#   2.3 更新后文件数量小于5 --- 不删除