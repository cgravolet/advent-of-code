package advent

import (
	"fmt"
	"io"
	"log"
	"strings"

	"github.com/cgravolet/adventofcode2022/pkg/utility"
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

func (a *AdventOfCode2022) Day03(input string) {
	day03part1(strings.NewReader(input))
	day03part2(strings.NewReader(input))
}

func day03part1(input io.Reader) {
	var sum int
	err := utility.ForEachLineInReader(input, func(s string) {
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

func day03part2(input io.Reader) {
	var sum int

	groups := make([][]Compartment, 0)

	err := utility.ForEachLineInReader(input, func(s string) {
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
