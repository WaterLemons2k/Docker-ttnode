# Docker-ttnode
系统: BusyBox 1.23  
版本: 1.0.0.384
## 使用
```
docker run -it \
-v /ttnode:/mnt/data/ttnode \
-e DISABLE=0 \
--net=host \
--restart=always \
waterlemons2k/ttnode
```
将 `/ttnode` 替换为主机的缓存目录
## 变量
```
DISABLE=0: 不禁用
DISABLE=1: 禁用签到和收星
DISABLE=2: 禁用甜糖
```
# 甜糖自动脚本
来源：[GitHub](https://github.com/axiang117/ttnode-auto) [恩山无线论坛](https://www.right.com.cn/forum/forum.php?mod=viewthread&tid=8259846)

## 支持以下功能：
1. 新版本API账号登录
2. 自动签到
3. 自动收取星愿
4. 登录token过期自动刷新token  


## 使用方法：
1. 运行 `token` 命令登录，按照提示输入手机号和短信验证码  
   备注：甜糖官方开启了图形验证码登录，我的程序中自动调用OCR识别验证码，有一定几率识别错误，登录失败了多试几次即可。注意不要太频繁重试，会被甜糖官方封锁
2. 如果上一步提示登录成功，会在 `/data` 目录生成 `token.txt`，此文件即为后续自动操作的登录凭证，不可删除或者修改
3. 已将 `signin` 命令加入任务计划中，每日03：45自动签到和收星  


#### 如果本程序对你有帮助，请在甜糖APP中填入作者的邀请码 004347 支持一下，并可以获得15张收益加速卡


如果对本程序有什么问题，可以联系作者邮箱axiang117@hotmail.com