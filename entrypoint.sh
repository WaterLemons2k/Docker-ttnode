#!/bin/bash
#https://stackoverflow.com/questions/2379829/while-loop-to-test-if-a-file-exists-in-bash
#https://github.com/ericwang2006/docker_ttnode/blob/master/build_dir/start.sh
#https://post.smzdm.com/p/awx4rqkk/
#https://blog.twofei.com/477/
#变量DISABLE:0为不禁用，1为禁用签到和收星，2为禁用ttnode

cd /data
if [ $(ps fax | grep '[c]ron' | wc -l) -lt 1 ]; then #如果带cron的进程数小于1
     echo "找不到cron，开始运行"
     cron
fi

if [ $DISABLE != "1" ]; then #如果DISABLE不为1
     while [ ! -e token.txt ]; do #如果找不到token.txt
         echo "找不到token.txt，运行token登录"
         ./token
     done
     
     echo "已登录，每天09:10签到和收星,日志保存到/data/signin.log"
     /data/signin > /data/signin.log 2>&1
     else #否则DISABLE为1
         echo "DISABLE为$DISABLE，禁用签到和收星"
fi

if [ $DISABLE != "2" ]; then #如果DISABLE不为2
     if [ $(ps fax | grep '[/]mnt/data/ttnode' | wc -l) -lt 1 ]; then #如果带ttnode的进程数小于1
         echo "找不到ttnode，开始运行"
         ./ttnode -p /mnt/data/ttnode -i uid.txt -d
         sleep 1s
         echo "请访问"
         echo "http://waterlemons2k.com/QRCode/?$(cat uid.txt)"
         echo "查看二维码"
     fi
     else #否则DISABLE为2
         echo "DISABLE为$DISABLE，禁用ttnode"
fi

if [ $(ps | grep '[b]ash' | wc -l) -lt 1 ]; then #如果带bash的进程数小于1
     echo "找不到bash，开始运行"
     bash
fi