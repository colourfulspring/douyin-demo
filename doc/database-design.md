## mysql表设计
根据[项目文档](https://bytedance.feishu.cn/docx/BhEgdmoI3ozdBJxly71cd30vnRc "https://bytedance.feishu.cn/docx/BhEgdmoI3ozdBJxly71cd30vnRc")中的前后端通信Protobuf接口定义，进行数据表设计，区分哪些项是数据库中需要的，哪些项是可以通过ORM计算得到的。

### 一些注意点
* 不要把图片、视频和大段文字直接存到数据库里。学simple-demo把视频存到public文件夹，通过查到的url再让客户端重定向访问即可，并在gin中配置路由即可。

### PowerDesigner的使用方法
PowerDesigner是辅助设计关系型数据库的数据表的软件。它提供一套标准化流程，将现实世界中的数据之间的抽象关系一步步转换为具体数据库中的数据表。根据软件说明，一次转换主要分为下面几个阶段：
* **Conceptual Data Model：** A conceptual data diagram provides a graphical view of the conceptual structure of an information system, and helps you identify the principal entities to be represented, their attributes, and the relationships between them.
* **Logical Data Model：** A logical data model (LDM) helps you analyze the structure of an information system, independent of any specific physical database implementation. An LDM has migrated entity identifiers and is less abstract than a conceptual data model (CDM), but does not allow you to model views, indexes and other elements that are available in the more concrete physical data model (PDM).
* **Physical Data Model：** A physical data model (PDM) helps you to analyze the tables, views, and other objects in a database, including multidimensional objects necessary for data warehousing. A PDM is more concrete than a conceptual (CDM) or logical (LDM) data model. You can model, reverse-engineer, and generate for all the most popular DBMSs.
