#!/usr/bin/env bash

#set node path
export NODE_HOME=/usr/local/n/versions/node/10.16.3
export PATH=$NODE_HOME/bin:$PATH

cd `dirname $0`
dir_name=`dirname $0`

node -v

log_file_path=`dirname $0`+'/server.log'

if [ -f ${log_file_path} ];then
    echo "file ${log_file_path} exists"
    count=`du -s ${log_file_path}|awk '{print $1}'`
    if [ $((count)) -gt 1000 ];then
        echo ">>>>>>>>>>>> gt 1000"
        echo ''>${log_file_path}
    else
        echo ">>>>>>>>>>>> lt 1000"
    fi
else
    echo "file ${log_file_path} not exists"
fi

num=`ps -ef|grep ${dir_name}|grep "webpack.dev.conf.js"|grep -v grep|wc -l`
if [ ${num} -lt 2 ]; then
    npm run dev &
fi
