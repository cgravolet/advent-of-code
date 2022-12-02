package main

import (
	"fmt"
	"log"
	"os"
	"sort"
	"strconv"

	"github.comcast.com/cgravo558/advent2022/pkg/utility"
)

/*
 * Input is number of calories each Elf is carrying. Each elf writes one item per line, and separates their own
 * inventory from the previous Elf's inventory by a blank line.
 *
 * 1. Find the elf carrying the most calories, how many calories is that Elf carrying?
 * 2. Find the top 3 elves that are carrying the most calories, how many calories in total?
 *
 * Sample input:
 * 1000
 * 2000
 * 3000
 *
 * 4000
 *
 * 5000
 * 6000
 */
func main() {
	lines, err := utility.ReadLinesFromFile(os.Args)

	if err != nil {
		log.Fatalf("Error reading lines from file: %v", err)
	}
	elfCalories := []int{0}

	for _, s := range lines {
		if len(s) == 0 {
			elfCalories = append(elfCalories, 0)
		} else {
			calories, err := strconv.Atoi(s)

			if err == nil {
				index := len(elfCalories) - 1
				elfCalories[index] += calories
			}
		}
	}

	sort.Slice(elfCalories, func(l, r int) bool {
		return elfCalories[l] > elfCalories[r]
	})

	// Elf with most calories
	mostCalories := elfCalories[0]
	fmt.Println(mostCalories)

	// Top three calories
	topThree := 0

	for i := 0; i < 3; i++ {
		if len(elfCalories) > i {
			topThree += elfCalories[i]
		}
	}
	fmt.Println(topThree)
}
