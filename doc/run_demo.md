### 使用Dockerfile构建镜像
在Dockerfile所在目录下运行如下命令：
```shell
docker build -t douyin .
```
-t表示构建的镜像名，这里为douyin。.表示Dockerfile所在目录。
建议构建时开启全局代理，否则下载可能失败。

构建完成后运行命令：
```shell
docker images
```
可以看到一个名为douyin的镜像。

### 使用git clone项目
根据文档，后端项目demo的链接为https://github.com/RaymondCode/simple-demo

运行如下命令即可
```shell
git clone https://github.com/RaymondCode/simple-demo.git
```
假设项目被clone到目录(your absolute path to repo)
### 通过Dockerfile创建容器
运行如下命令，通过镜像douyin来创建容器：
```shell
docker run -it -v (your absolute path to repo):/home/douyin-demo -p 8080:8080 douyin /bin/bash
```
-i表示交互操作，-t表示终端，-v (path1):(path2)表示将主机path1挂载到容器内path2，-p (port1):(port2)表示将容器的8080端口绑定到主机的8080端口。
创建完成后，会显示终端。在终端中进入目录/home/douyin-demo，将go加入环境变量，并用其构建项目可执行文件。
```shell
cd /home/douyin-demo
export PATH=$PATH:/usr/local/go/bin
go build
```
可以看到目录中出现了可执行文件simple-demo。运行如下命令：
```shell
./simple-demo
```
可以看到后端成功运行，终端显示出gin库的日志，以及正在监听8080端口。

在浏览器中访问[http://127.0.0.1:8080/douyin/feed/](http://127.0.0.1:8080/douyin/feed/ "http://127.0.0.1:8080/douyin/feed/")。可以看到返回一个json。