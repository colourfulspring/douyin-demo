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
	dsn := "root:123456@tcp(127.0.0.1:3306)/douyin?charset=utf8mb4&parseTime=True&loc=Local"
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
