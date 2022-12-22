package advent

import (
	"fmt"
	"regexp"
	"strconv"
)

type MonkeyEquation struct {
	Left     string
	Right    string
	Operator string
}

func (me *MonkeyEquation) solve(lhs, rhs int) (int, bool) {
	switch me.Operator {
	case "+":
		return lhs + rhs, true
	case "-":
		return lhs - rhs, true
	case "*":
		return lhs * rhs, true
	case "/":
		return lhs / rhs, true
	}
	return -1, false
}

func (me *MonkeyEquation) trySolve(m map[string]int) (int, bool) {
	lnum, lok := m[me.Left]
	rnum, rok := m[me.Right]

	if lok && rok {
		return me.solve(lnum, rnum)
	}
	return -1, false
}

func (a *AdventOfCode2022) Day21(input string) {
	part1 := solveDay21Part1(input)
	fmt.Printf("Part 1: %d\n", part1)
}

func parseInputDay21(input string) (m map[string]int, e map[string]MonkeyEquation) {
	m = make(map[string]int)
	e = make(map[string]MonkeyEquation)
	numre := regexp.MustCompile(`(\w+): (-?\d+)`)
	equre := regexp.MustCompile(`(\w+): (\w+) ([\-+*/]) (\w+)`)

	for _, matches := range numre.FindAllStringSubmatch(input, -1) {
		if len(matches) != 3 {
			continue
		}
		num, _ := strconv.Atoi(matches[2])
		m[matches[1]] = num
	}

	for _, matches := range equre.FindAllStringSubmatch(input, -1) {
		if len(matches) != 5 {
			continue
		}
		eq := MonkeyEquation{matches[2], matches[4], matches[3]}
		e[matches[1]] = eq
	}
	return
}

func solveDay21Part1(input string) int {
	m, e := parseInputDay21(input)
	rootEquation, ok := e["root"]
	delete(e, "root")

	if !ok {
		return -1
	}

	for len(e) > 0 {
		for key, val := range e {
			product, ok := val.trySolve(m)

			if ok {
				m[key] = product
				delete(e, key)
			}
			product, ok = rootEquation.trySolve(m)

			if ok {
				return product
			}
		}
	}
	return -1
}

func solveDay21Part2(input string) int {
	m, e := parseInputDay21(input)
	delete(m, "humn")
	delete(e, "root")
	return -1
}
