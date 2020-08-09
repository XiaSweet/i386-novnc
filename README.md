# i386-novnc
基于 oott123/novnc [Docker](https://hub.docker.com/r/oott123/novnc) 镜像所修改的X86版本novnc-Docker镜像
## 注意事项
这个镜像只是一个Docker制作的底包，使用方法请浏览以下仓库：
  
https://github.com/oott123/docker-novnc
## 致谢
[i386/ubuntu](https://hub.docker.com/r/i386/ubuntu) Docker镜像
	
[oott123/novnc](https://github.com/oott123/docker-novnc) Docker镜像
## 可选变量
### 你可以修改的变量
可用变量值 | 默认值 | 备注
:-:|:-:|:-:
VNC_GEOMETRY |1000x600 | VNC端的远程分辨率
VNC_PASSWD  |66666666 | VNC端的登陆密码
	
### 容器需要占用的端口
端口 |  备注
:-:|:-:
5901 | tigervnc
9000 | Nginx
9001 | websockify
## 识别代码
xxt-dice-lib:novncX86
