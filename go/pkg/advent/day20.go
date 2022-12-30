package advent

import (
	"container/ring"
	"fmt"
	"image"
	"strconv"
	"strings"
)

func (a *AdventOfCode2022) Day20(input string) {
	part1 := solveDay20Part1(input)
	fmt.Printf("Part 1: %d\n", part1)
}

func parseInputDay20(input string) (nums []int) {
	for _, line := range strings.Split(strings.TrimSpace(input), "\n") {
		num, err := strconv.Atoi(line)
		if err != nil {
			continue
		}
		nums = append(nums, num)
	}
	return
}

func solveDay20Part1(input string) int {
	var sum int
	nums := parseInputDay20(input)
	r := mixNumbers(nums)

	for r.Value != 0 {
		r = r.Next()
	}

	for i := 1000; i <= 3000; i += 1000 {
		r = r.Move(1000)
		sum += r.Value.(int)
	}
	return sum
}

// Helpers

func mixNumbers(nums []int) *ring.Ring {
	positions := make(map[image.Point]*ring.Ring, len(nums))
	r := ring.New(len(nums))

	for i, num := range nums {
		positions[image.Point{i, num}] = r
		r.Value = num
		r = r.Next()
	}

	l := len(nums) - 1
	hl := l >> 1

	for i, num := range nums {
		r = positions[image.Point{i, num}].Prev()
		removed := r.Unlink(1)
		if num > hl || num < -hl {
			num %= l
			switch {
			case num > hl:
				num -= l
			case num < -hl:
				num += l
			}
		}
		r.Move(num).Link(removed)
	}

	return r
}
