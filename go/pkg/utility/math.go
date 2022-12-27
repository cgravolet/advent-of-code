package utility

import "math"

func MaxInt(nums ...int) int {
	maxNum := math.MinInt
	for _, num := range nums {
		if num > maxNum {
			maxNum = num
		}
	}
	return maxNum
}

func MinInt(nums ...int) int {
	minNum := math.MaxInt
	for _, num := range nums {
		if num < minNum {
			minNum = num
		}
	}
	return minNum
}
