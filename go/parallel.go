package main

import (
	"fmt"
	"time"
	"testing"
)

func main() {
	result := testing.Benchmark(func(b *testing.B) { run() })
	fmt.Println(result.T)
}

func run() {
	isFin1 := make(chan bool)
	isFin2 := make(chan bool)
	isFin3 := make(chan bool)

	fmt.Println("Start!")
	go func() {
		process("A")
		isFin1 <- true
	}()
	go func() {
		process("B")
		isFin2 <- true
	}()
	go func() {
		process("C")
		isFin3 <- true
	}()

	<-isFin1
	<-isFin2
	<-isFin3
	fmt.Println("Finish!")
}

func process(name string) {
	time.Sleep(2 * time.Second)
	fmt.Println(name)
}
