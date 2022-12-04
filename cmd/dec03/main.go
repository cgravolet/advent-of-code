package main

import (
	"fmt"
	"log"
	"os"
	"strings"

	"github.comcast.com/cgravo558/advent2022/pkg/utility"
)

type Compartment string
type Item rune
type Items []Item

func (lhs Compartment) GetCommonItems(rhs Compartment) Items {
	commonItems := make(Items, 0)
	for _, el := range lhs {
		if strings.IndexRune(string(rhs), el) > -1 && strings.IndexRune(string(commonItems), el) == -1 {
			commonItems = append(commonItems, Item(el))
		}
	}
	return commonItems
}

func (i Item) Priority() int {
	if int(i) > 96 {
		return int(i) - 96
	} else {
		return int(i) - 64 + 26
	}
}

func (i Items) Priority() int {
	p := 0
	for _, j := range i {
		p += j.Priority()
	}
	return p
}

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
		mid := len(s) / 2
		commonItems := Compartment(s[:mid]).GetCommonItems(Compartment(s[mid:]))
		sum += commonItems.Priority()
	})

	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("Priority sum of common items (part 1): %d\n", sum)
}

func part2() {
	var sum int

	groups := make([][]Compartment, 0)

	err := utility.ForEachLineInFile(os.Args[1], func(s string) {
		index := len(groups) - 1

		if index < 0 || len(groups[index]) == 3 {
			index += 1
			groups = append(groups, []Compartment{})
		}
		groups[index] = append(groups[index], Compartment(s))
	})

	if err != nil {
		log.Fatal(err)
	}

	for _, g := range groups {

		if len(g) <= 0 {
			continue
		}
		commonItems := Items(g[0])

		for r := 1; r < len(g); r += 1 {
			commonItems = g[r].GetCommonItems(Compartment(commonItems))
		}
		sum += commonItems.Priority()
	}
	fmt.Printf("Priority sum of badges (part 2): %d\n", sum)
}
