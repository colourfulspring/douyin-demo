package controller

import (
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

var db *gorm.DB = initDB()

func initDB() *gorm.DB {
	// 连接数据库
	dsn := "root:123456@tcp(127.0.0.1:3306)/douyin?charset=utf8mb4&parseTime=True&loc=Local"
	db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{})
	if err != nil {
		panic("failed to connect database")
	}
	return db
}
