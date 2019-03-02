package main

import (
	"fmt"
	"math"
)

func entropy(num float64) float64 {
	p := num / 100.0

	result := -p * math.Log2(p) - (1.0 - p) * math.Log2(1.0 - p)
	return result
}

func main() {
	var i float64

	fmt.Printf("0,1,0\n")

	for i = 1.0; i < 100.0; i++ {
		fmt.Printf("%f,%f,%f\n", i / 100.0, 1.0 - i / 100.0, entropy(i))
	}

	fmt.Printf("1,0,0\n")
}
