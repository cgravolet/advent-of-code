package advent

import (
	"container/ring"
	"fmt"
	"strings"
)

type JetDirection string

const (
	JetLeft  JetDirection = ">"
	JetRight JetDirection = "<"
)

func (a *AdventOfCode2022) Day17(input string) {
	part1 := solveDay17Part1(input)
	fmt.Printf("Part 1: %d\n", part1)
}

func parseInputDay17(input string) *ring.Ring {
	input = strings.TrimSpace(input)
	r := ring.New(len(input))
	for _, d := range input {
		r.Value = JetDirection(d)
		r.Next()
	}
	return r
}

func solveDay17Part1(input string) int {
	// max := 2022
	r := parseInputDay17(input)
	fmt.Printf("%v\n", r)
	return -1
}
