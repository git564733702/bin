#! /bin/bash
var01=$(ps -aux | grep "python3.6 -m ankisyncd")
arry01=(${var01// / }) # 分割，分隔符为空格
# echo ${arry01[1]}
pid01=${arry01[1]}
kill -15 $pid01
echo "kill anki_server done."
