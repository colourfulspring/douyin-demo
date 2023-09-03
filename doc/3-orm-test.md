### ORM
ORM全称为Object Relation Mapping。ORM技术旨在让程序员通过自己熟悉的任何语言（如Python，C++）中的面向对象特性来完成复杂SQL语句编写和数据库访问的工作。

### pros
* 使用自己熟悉的语言，不需要专门去学习一门日常不太使用的SQL语言。
* 程序与底层数据库无关，可以跨多个数据库使用。
* ORM还可以提供一些SQL语言实现较为困难的高级功能，如连接池等。
* 对于新手来说，ORM可以帮助用户优化SQL语句，使其比直接写SQL更加高效。

### cons
* 对于SQL高手，ORM的效率可能不如自己编写的SQL语句。
* 学习ORM需要成本。
* ORM的初始化配置可能较为繁琐。
* ORM的封装可能减弱程序员对SQL的了解。

### go语言的ORM库——gorm
我们使用gorm库从数据库中获取数据，并加工后通过文档中的protobuf API返回给前端。

GORM(Go语言对象关系映射)是一个用于Go语言的开源对象关系映射库。它为Go程序提供了一种简单、习惯性的方式来与数据库进行交互。下面是关于GORM需要了解的几点关键信息:

它基于database/sql构建,目的是与数据库无关,支持PostgreSQL、MySQL、SQLite等数据库。
GORM通过将Go结构体映射到数据库表提供了一种面向对象的方式来与数据库交互。您可以定义与表对应的模型,GORM会自动在Go结构体和数据库行之间进行转换。
它包含关联(模型之间的关系)、钩子(回调)、事务、查询构建等功能,这些使得使用数据库更加高效。
GORM Opinionated,旨在促进一种符合Go语言理念(如习惯用法和简单性)的标准方式来使用数据库。
它由Jinzhu开发和维护,拥有活跃的开源社区贡献。像Shopify这样的大公司在生产中使用GORM。
总体上,与直接使用database/sql相比,GORM大大简化了在Go中构建使用数据库的应用程序的难度。它减少了样板代码量,是一个强大的Go开发人员的ORM库。

### 配置gorm环境
打开go.mod文件，在第一个require处加入两项，得到如下内容：
```go
require (
	github.com/gavv/httpexpect/v2 v2.8.0
	github.com/gin-gonic/gin v1.7.7
	github.com/stretchr/testify v1.7.0
	gorm.io/driver/mysql v1.7.1
	gorm.io/gorm v1.25.4
)
```
运行如下命令，下载gorm包。
```shell
go get
```

### 编写gorm程序读取mysql数据
根据User表的定义，编写程序./test/orm_test.go如下：
```go
package test

import (
	"fmt"

	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

type User_gorm struct {
	UserID          int64  `gorm:"column:user_id"`
	UserName        string `gorm:"column:user_name"`
	Avatar          string `gorm:"avatar"`
	Signature       string `gorm:"signature"`
	BackgroundImage string `gorm:"background_image"`
	Password        string `gorm:"password"`
	Token           string `gorm:"token"`
}

func main() {

	// 连接数据库
	dsn := "root:password@tcp(127.0.0.1:3306)/database?charset=utf8mb4&parseTime=True&loc=Local"
	db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{})
	if err != nil {
		panic("failed to connect database")
	}

	// 获取所有记录
	var users []User_gorm
	db.Find(&users)

	// 打印记录
	fmt.Println("ID\tName\tAge")
	for _, user := range users {
		fmt.Printf("%d\t%s\t%s\n", user.UserID, user.UserName, user.Password)
	}
}

```

### 错误解决1
使用命令
```shell
go run orm_test.go
```
运行main.go文件。报错如下：

ERROR 1130: Host ‘xxx.xxx.xxx.xxx’ is not allowed to connect to this MySQL server.

根据链接 https://www.shulanxt.com/doc/dbdoc/mysql-1130 链接的**方法二：改表法**成功解决。

### 错误解决2
继续使用命令
```shell
go run orm_test.go
```
运行orm_test.go文件。报错如下：

2023/08/30 15:13:36 /home/douyin-demo/simple-demo/orm_test.go:31 Error 1146 (42S02): Table 'douyin.users' doesn't exist

[0.931ms] [rows:0] SELECT * FROM `users`
ID      Name    Age

初步思考是因为gorm对结构体名和数据表名的转换关系默认为直接取消大小写并在末尾加s。

根据 https://blog.csdn.net/lilongsy/article/details/127783649 链接中可知通过配置gorm.Config中的NamingStrategy来选择结构体名和数据表名的转换关系。该方法需要特别同步数据库和ORM代码中的表名。
```go
db, err = gorm.Open(mysql.Open(dsn), &gorm.Config{
		NamingStrategy: schema.NamingStrategy{
			TablePrefix:   "",   // 表前缀
			SingularTable: true, // 禁用表名复数
		}})
```


根据 https://zhuanlan.zhihu.com/p/651985444 链接中可知，另一种方法是直接使用db.Table('table name')显式指定mysql数据表名。该方法不需要特别同步数据库和ORM代码中的表名。

### 最终成功代码
```go
package test

import (
	"fmt"

	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

type User struct {
	UserID          int64  `gorm:"column:user_id"`
	UserName        string `gorm:"column:user_name"`
	Avatar          string `gorm:"avatar"`
	Signature       string `gorm:"signature"`
	BackgroundImage string `gorm:"background_image"`
	Password        string `gorm:"password"`
	Token           string `gorm:"token"`
}

func main() {

	// 连接数据库
	dsn := "root:password@tcp(127.0.0.1:3306)/database?charset=utf8mb4&parseTime=True&loc=Local"
	db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{})
	if err != nil {
		panic("failed to connect database")
	}

	// 获取所有记录
	var users []User
	db.Table("User").Find(&users)

	// 打印记录
	fmt.Println("ID\tName\tAge")
	for _, user := range users {
		fmt.Printf("%d\t%s\t%s\n", user.UserID, user.UserName, user.Password)
	}
}
```
