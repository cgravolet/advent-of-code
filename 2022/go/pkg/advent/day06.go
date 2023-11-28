package advent

import (
	"fmt"
	"io"
	"strings"

	"github.com/cgravolet/adventofcode2022/pkg/utility"
)

// Lifecycle

func (a *AdventOfCode2022) Day06(input string) {
	part1, _ := findMarkerInFile(strings.NewReader(input), 4)
	part2, _ := findMarkerInFile(strings.NewReader(input), 14)
	fmt.Printf("Part 1: %d\n", part1)
	fmt.Printf("Part 2: %d\n", part2)
}

// Internal functions

func findMarkerInFile(input io.Reader, size int) (int, error) {
	charset := make([]string, 0)
	marker := -1

	err := utility.ForEachRuneInReader(input, func(i int, s string) bool {
		charset = append(charset, s)

		if len(charset) > size {
			charset = charset[1:]
		}
		charmap := make(map[string]bool, 0)

		for c := 0; c < len(charset); c++ {
			charmap[charset[c]] = true
		}

		if len(charmap) == size {
			marker = i + 1
			return true
		}
		return false
	})
	return marker, err
}
