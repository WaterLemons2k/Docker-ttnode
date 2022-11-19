#!/bin/bash
#https://stackoverflow.com/questions/2379829/while-loop-to-test-if-a-file-exists-in-bash
#https://github.com/ericwang2006/docker_ttnode/blob/master/build_dir/start.sh
#https://post.smzdm.com/p/awx4rqkk/
#https://blog.twofei.com/477/
#https://stackoverflow.com/questions/71409553/crontab-not-getting-my-current-envrioment-variables
#变量DISABLE：0=不禁用，1=禁用签到和收星，2=禁用甜糖
#[$(date '+%F %T')]: 现在的日期和时间，示例:[1970-01-01 00:00:00]

cd /data
if [ ! -e /var/spool/cron/crontabs/root ]; then #如果找不到crontab
     echo "[$(date '+%F %T' )] 创建crontab"
     echo -e "DISABLE=$DISABLE\n10 9 * * * /data/entrypoint.sh > /data/log 2>&1\n" > cron #向cron写入变量DISABLE和任务，以换行符结尾
     crontab cron #加载cron
     rm cron #删除cron
fi
     
if [ $(ps -e | grep '[c]ron' | wc -l) -lt 1 ]; then #如果名称带cron的进程数小于1
     echo "[$(date '+%F %T')] 运行cron"
     cron
fi

if [[ $DISABLE != "1" ]]; then #如果DISABLE!=1
     while [ ! -e token.txt ]; do #如果找不到token.txt
         echo "[$(date '+%F %T')] 找不到token.txt，开始登录"
         ./token
     done
     
     echo "[$(date '+%F %T')] 已登录，开始签到和收星"
     ./signin
     
     else #否则DISABLE=1
         echo "[$(date '+%F %T')] DISABLE=$DISABLE，禁用签到和收星"
fi

if [[ $DISABLE != "2" ]]; then #如果DISABLE!=2
     if [ $(ps -e | grep '[/]mnt/data/ttnode' | wc -l) -lt 1 ]; then #如果名称带ttnode的进程数小于1
         echo "[$(date '+%F %T')] 运行甜糖"
         ./ttnode -p /mnt/data/ttnode -i uid.txt -d
         sleep 1s
         echo -e "[$(date '+%F %T')] 查看二维码，请访问\n[$(date '+%F %T')] http://waterlemons2k.com/QRCode/?$(cat uid.txt)"
     fi
     else #否则DISABLE=2
         echo "[$(date '+%F %T')] DISABLE=$DISABLE，禁用甜糖"
fi

if [ $(ps -e | grep '[b]ash' | wc -l) -lt 1 ]; then #如果名称带bash的进程数小于1
     echo "[$(date '+%F %T')] 找不到bash，开始运行"
     bash
fi