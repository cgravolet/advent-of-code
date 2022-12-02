package main

import (
	"fmt"
	"log"
	"os"
	"sort"
	"strconv"

	"github.comcast.com/cgravo558/advent2022/pkg/utility"
)

func main() {
	calories := []int{0}

	err := utility.ForEachLineInFile(os.Args[1], func(s string) {
		if len(s) == 0 {
			calories = append(calories, 0)
			return
		}
		c, err := strconv.Atoi(s)

		if err == nil {
			calories[len(calories)-1] += c
		}
	})

	if err != nil {
		log.Fatal(err)
	}

	sort.Slice(calories, func(l, r int) bool {
		return calories[l] > calories[r]
	})

	// Elf with most calories
	mostCalories := calories[0]
	fmt.Printf("Most calories (part 1): %d\n", mostCalories)

	// Top three calories
	topThree := 0

	for i := 0; i < 3; i++ {
		if len(calories) > i {
			topThree += calories[i]
		}
	}
	fmt.Printf("Top three combined (part 2): %d\n", topThree)
}
