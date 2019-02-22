package main

import (
	"fmt"
	"time"
)

func main() {
	fmt.Printf("Hello World!\n")

	tz, _ := time.LoadLocation("Asia/Tokyo")
	tm := time.Date(2019, 2, 22, 10, 30, 50, 0, tz)
	fmt.Println(tm)
	fmt.Println(tm.Unix())
	fmt.Println(time.Now().Unix())
	fmt.Println(time.Unix(1550799050, 0))
}
