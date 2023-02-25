#!/bin/sh
#https://stackoverflow.com/questions/2379829/while-loop-to-test-if-a-file-exists-in-bash
#https://github.com/ericwang2006/docker_ttnode/blob/master/build_dir/start.sh
#https://post.smzdm.com/p/awx4rqkk/
#https://blog.twofei.com/477/
#https://unix.stackexchange.com/questions/140750
#https://www.shellcheck.net/wiki/SC2126
#变量 AUTO：0=禁用自动脚本，1=启用自动脚本
#变量 TTNODE：0=禁用甜糖，1=启用甜糖
#[$(date '+%F %T')]: 当前日期和时间，示例：[1970-01-01 00:00:00]
set -e
cd /data

if [ $(ps | grep -c '[c]rond') -lt 1 ]; then #如果名称带 crond 的进程数小于 1
    echo "[$(date '+%F %T')] 运行 crond"
    crond
fi

if [ "$AUTO" = "1" ]; then #如果 AUTO=1
    while [ ! -e token.txt ]; do #如果找不到 token.txt
        echo "[$(date '+%F %T')] 找不到 token.txt，登录"
        ./token
    done
     
    SHUF=$(shuf -i 30-90 -n 1) #生成 1 行 30-90 之间的随机数
    echo "[$(date '+%F %T')] $SHUF 秒后签到和收星..."
    sleep $SHUF
    ./signin
     
else #否则 AUTO!=1
    echo "[$(date '+%F %T')] AUTO=$AUTO，禁用自动脚本"
fi

if [ "$TTNODE" = "1" ]; then #如果 TTNODE=1
    if [ $(ps | grep -c '[t]tnode') -lt 1 ]; then #如果名称带 ttnode 的进程数小于 1
        echo "[$(date '+%F %T')] 运行甜糖"
        ./ttnode -p /mnt/data/ttnode -i uid.txt -d
        sleep 1
        UID=$(cat uid.txt)
        echo -e "[$(date '+%F %T')] UID：$UID\n[$(date '+%F %T')] 二维码：https://qrcode-2cc.pages.dev/?$UID"
    fi
    
else #否则 TTNODE!=1
    echo "[$(date '+%F %T')] TTNODE=$TTNODE，禁用甜糖"
fi
exec "$@" #运行脚本所有参数
