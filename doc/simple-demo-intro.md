### main.go
* 开一个新协程调用serviceRunMessageServer。（暂时不懂）
* 新建一个默认gin.Engine对象，包含中间件Logger和Recovery。
* 处理URL路由。
* 运行gin.Engine，开启服务。

### service.go
暂时没懂。

### router.go
处理URL路由。

注意到所有的URL都是形如/douyin/xxx/(yyy)。

xxx代表对应函数实现在simple-demo/controller/xxx.go文件内，是对所有需求的高层划分。

yyy代表对应函数实现在simple-demo/controller/xxx.go文件内的XxxYyy函数，可以省略，是对所有需求的底层划分。

### controller/demo_data.go
该文件展示了部分数据库和ORM应该给出的数据在go中的表示。