package advent

import (
	"fmt"
	"strconv"
	"strings"

	"github.com/cgravolet/adventofcode2022/pkg/utility"
)

func (a *AdventOfCode2022) Puzzle202225(input string) {
	part1a, part1b := solvePuzzle202225Part1(input)
	fmt.Printf("Part 1: %s (%d)\n", part1b, part1a)
}

// Data structures

type SnafuNumber string

func (sn SnafuNumber) IntValue() int {
	var sum int
	pow := 1
	for i := len(sn) - 1; i >= 0; i-- {
		var num int
		switch sn[i] {
		case '-':
			num = -1
		case '=':
			num = -2
		default:
			num, _ = strconv.Atoi(string(sn[i]))
		}
		sum += pow * num
		pow *= 5
	}
	return sum
}

func NewSnafuNumber(input int) SnafuNumber {
	var snafu string
	sum := input

	for sum > 0 {
		snafu = string("=-012"[(sum+2)%5]) + snafu
		sum = (sum + 2) / 5
	}
	return SnafuNumber(snafu)
}

// Solve

func solvePuzzle202225Part1(input string) (int, SnafuNumber) {
	var sum int
	utility.ForEachLineInReader(strings.NewReader(input), func(s string) {
		sum += SnafuNumber(s).IntValue()
	})
	return sum, NewSnafuNumber(sum)
}
