package advent

import (
	"fmt"
	"strconv"
	"strings"

	"github.com/cgravolet/adventofcode2022/pkg/utility"
)

func (a *AdventOfCode2022) Day20(input string) {
	seq := parseInputDay20(input)
	part1 := solveDay20Part1(seq)
	fmt.Printf("Part 1: %d\n", part1)
}

func parseInputDay20(input string) []int {
	sequence := make([]int, 0)
	utility.ForEachLineInReader(strings.NewReader(input), func(s string) {
		num, err := strconv.Atoi(s)
		if err == nil {
			sequence = append(sequence, num)
		}
	})
	return sequence
}

/*
[1, 2, -3, 4, 0, 3, -2]

len = 7
item 10 is at index 3
item -3 is at index 2 and wants to move to index 6

i is 3, move forward 4 to end at index 1

4 is at index 5
len is 7
4 wants to move to index 3
*/
func solveDay20Part1(seq []int) int {
	result := make([]int, len(seq))
	copy(result, seq)

	var cur int

	for _, val := range result {
		val = result[cur]

		if val == 0 {
			cur++
			continue
		}
		to := (cur + val) % len(seq)

		if cur+val > len(seq) {
			to++
		}
		result, _ = utility.MoveElement(result, cur, to)

		if to > cur {
			// no-op
		} else if to <= cur {
			cur++
		}
	}

	// Solve
	zi := utility.SliceIndex(len(result), func(i int) bool {
		return result[i] == 0
	})
	var sum int
	for _, num := range []int{zi + 1000, zi + 2000, zi + 3000} {
		sum += result[num%len(result)]
	}
	return sum
}
