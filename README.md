# ttnode
系统:Debian 10  
架构:x86_64  
脚本:https://www.right.com.cn/forum/forum.php?mod=viewthread&tid=8259846  
下载并运行容器:
```
docker run -it \
--net=host \
--restart=always \
-e DISABLE=0 \
waterlemons2k/ttnode
```
变量(-e DISABLE=0):
```
DISABLE=0:不禁用
DISABLE=1:禁用签到和收星
DISABLE=2:禁用ttnode
```
# 甜糖自动脚本
## 支持以下功能：
1. 新版本API账号登录
2. 自动签到
3. 自动收取星愿
4. 登录token过期自动刷新token
5. 自动激活电费卡
## 使用方法:
1. 运行 `./token` 命令登录，按照提示输入手机号和短信验证码  
备注：甜糖官方开启了图形验证码登录，我的程序中自动调用OCR识别验证码，有一定几率识别错误，登录失败了多试几次即可。注意不要太频繁重试，会被甜糖官方封锁
2. 如果上一步提示成功，会在当前目录生成token.txt，此文件即为后续自动操作的登录凭证，不可删除
3. 已将 `./signin` 加入定时任务，每日09:10自动签到和收星

#### 如果本项目对你有帮助，请在甜糖APP中填入作者的邀请码 004347 支持一下作者，并可以获得15张收益加速卡

如果对本项目有什么问题，可以联系脚本作者邮箱axiang117@hotmail.com
