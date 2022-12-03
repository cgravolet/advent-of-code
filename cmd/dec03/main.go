package main

import (
	"fmt"
	"log"
	"os"
	"strings"

	"github.comcast.com/cgravo558/advent2022/pkg/utility"
)

func main() {
	part1()
	part2()
}

func part1() {
	var sum int
	err := utility.ForEachLineInFile(os.Args[1], func(s string) {
		if len(s) == 0 {
			return
		}

		// Split rucksack into 2 compartments
		mid := len(s) / 2
		c1 := s[:mid]
		c2 := s[mid:]

		// Find priority of common item in compartments and add it to sum
		var commonItems string

		for _, el := range c1 {
			if strings.IndexRune(c2, el) > -1 && strings.IndexRune(commonItems, el) == -1 {
				commonItems += string(el)

				if int(el) > 96 {
					sum += int(el) - 96
				} else {
					sum += int(el) - 64 + 26
				}
			}
		}
	})

	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("Priority sum of common items (part 1): %d\n", sum)
}

func part2() {
	var sum int
	fmt.Printf("Priority sum of badges (part 2): %d\n", sum)
}
