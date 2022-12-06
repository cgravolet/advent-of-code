package main

import (
	"fmt"
	"os"

	"github.comcast.com/cgravo558/advent2022/pkg/utility"
)

// Lifecycle

func main() {
	path := os.Args[1]
	part1, _ := findMarkerInFile(path, 4)
	part2, _ := findMarkerInFile(path, 14)
	fmt.Printf("Day 6 answer (part 1): %d\n", part1)
	fmt.Printf("Day 6 answer (part 2): %d\n", part2)
}

// Private functions

func findMarkerInFile(path string, size int) (int, error) {
	i := 0
	charset := make([]string, 0)
	marker := -1

	err := utility.ForEachRuneInFile(path, func(s string) bool {
		i += 1
		charset = append(charset, s)

		if len(charset) > size {
			charset = charset[1:]
		}
		charmap := make(map[string]bool, 0)

		for c := 0; c < len(charset); c++ {
			charmap[charset[c]] = true
		}

		if len(charmap) == size {
			marker = i
			return true
		}
		return false
	})
	return marker, err
}
