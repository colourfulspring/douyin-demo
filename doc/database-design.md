## mysql表设计
根据[项目文档](https://bytedance.feishu.cn/docx/BhEgdmoI3ozdBJxly71cd30vnRc "https://bytedance.feishu.cn/docx/BhEgdmoI3ozdBJxly71cd30vnRc")中的前后端通信Protobuf接口定义，进行数据表设计，区分哪些项是数据库中需要的，哪些项是可以通过ORM计算得到的。

### 一些注意点
* 不要把图片、视频和大段文字直接存到数据库里。学simple-demo把视频存到public文件夹，通过查到的url再让客户端重定向访问即可，并在gin中配置路由即可。

### PowerDesigner的使用方法
PowerDesigner是辅助设计关系型数据库的数据表的软件。它提供一套标准化流程，将现实世界中的数据之间的抽象关系一步步转换为具体数据库中的数据表。根据软件说明，一次转换主要分为下面几个阶段：
* **Conceptual Data Model：** A conceptual data diagram provides a graphical view of the conceptual structure of an information system, and helps you identify the principal entities to be represented, their attributes, and the relationships between them.
* **Logical Data Model：** A logical data model (LDM) helps you analyze the structure of an information system, independent of any specific physical database implementation. An LDM has migrated entity identifiers and is less abstract than a conceptual data model (CDM), but does not allow you to model views, indexes and other elements that are available in the more concrete physical data model (PDM).
* **Physical Data Model：** A physical data model (PDM) helps you to analyze the tables, views, and other objects in a database, including multidimensional objects necessary for data warehousing. A PDM is more concrete than a conceptual (CDM) or logical (LDM) data model. You can model, reverse-engineer, and generate for all the most popular DBMSs.

使用PowerDesigner软件设计的数据表见/database/crebas.sql。

### 开启mysqld服务
新建一个docker内的终端，运行下列命令：
```shell
mysqld --initialize --console
```
该命令会完成mysqld服务初始化配置，并生成一个暂时的root用户密码。
```
[Server] A temporary password is generated for root@localhost: (password)
```

接下来运行下列命令，打开mysqld服务。
```shell
mysqld -u root
```
然后关闭终端。

### 连接mysql服务并修改root用户密码
新建一个终端，输入下列命令：
```shell
mysql -u root -p
```
在输入密码界面输入上一节生成的密码(password)，登录成功后界面显示
```
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 9
Server version: 8.0.34

...

mysql>
```
输入下面的sql语句，将引号内的(new password)替换为新密码：
```sql
ALTER USER 'root'@'localhost' IDENTIFIED BY '(new password)';
```
修改完成后输入exit，即可退出mysql，后续使用root用户登录时均使用新密码即可。