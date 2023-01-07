package advent

import (
	"fmt"
	"math"
	"regexp"
	"strconv"
)

func (a *AdventOfCode2022) Day21(input string) {
	part1 := solveDay21Part1(input)
	part2 := solveDay21Part2(input)
	fmt.Printf("Part 1: %d\n", part1)
	fmt.Printf("Part 2: %d\n", part2)
}

// Data structures

type YellerMonkey struct {
	value    int
	didYell  bool
	left     string
	right    string
	operator string
}

type YellerMonkeyGroup map[string]YellerMonkey

func (g YellerMonkeyGroup) GetValueFromMonkey(n string) float64 {
	m := g[n]

	if m.didYell {
		return float64(m.value)
	}
	lhs := g.GetValueFromMonkey(m.left)
	rhs := g.GetValueFromMonkey(m.right)

	switch m.operator {
	case "+":
		return lhs + rhs
	case "-":
		return lhs - rhs
	case "*":
		return lhs * rhs
	case "/":
		return lhs / rhs
	}
	return 0
}

// Parse

func parseInputDay21(input string) YellerMonkeyGroup {
	m := make(YellerMonkeyGroup)
	numre := regexp.MustCompile(`(\w+): (-?\d+)`)
	equre := regexp.MustCompile(`(\w+): (\w+) ([\-+*/]) (\w+)`)

	for _, matches := range numre.FindAllStringSubmatch(input, -1) {
		if len(matches) != 3 {
			continue
		}
		num, _ := strconv.Atoi(matches[2])
		m[matches[1]] = YellerMonkey{value: num, didYell: true}
	}

	for _, matches := range equre.FindAllStringSubmatch(input, -1) {
		if len(matches) != 5 {
			continue
		}
		m[matches[1]] = YellerMonkey{didYell: false, left: matches[2], right: matches[4], operator: matches[3]}
	}
	return m
}

// Solve

func solveDay21Part1(input string) int {
	m := parseInputDay21(input)
	return int(m.GetValueFromMonkey("root"))
}

func solveDay21Part2(input string) int {
	m := parseInputDay21(input)
	root := m["root"]
	root.operator = "-"
	m["root"] = root
	dir := m.GetValueFromMonkey(root.left) - m.GetValueFromMonkey(root.right)
	low, high := 0, math.MaxInt
	diff := m.GetValueFromMonkey("root")

	for math.Abs(diff) > 0.1 {
		val := (high-low)/2 + low
		m["humn"] = YellerMonkey{value: val, didYell: true}
		diff = m.GetValueFromMonkey("root")

		if dir < 0 {
			if diff < 0 {
				low = val
			} else {
				high = val
			}
		} else {
			if diff > 0 {
				low = val
			} else {
				high = val
			}
		}
	}
	return m["humn"].value
}
