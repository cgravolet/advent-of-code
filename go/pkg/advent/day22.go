package advent

import (
	"fmt"
	"regexp"
	"strconv"
	"strings"

	"github.com/cgravolet/adventofcode2022/pkg/utility"
)

func (a *AdventOfCode2022) Day22(input string) {
	part1 := solveDay22Part1(input)
	part2 := solveDay22Part2(input)
	fmt.Printf("Part 1: %d\n", part1)
	fmt.Printf("Part 2: %d\n", part2)
}

// Data structures

type PathDirection int

const (
	PathRight PathDirection = iota
	PathDown
	PathLeft
	PathUp
)

func (p PathDirection) turn(d string) PathDirection {
	switch d {
	case "R":
		switch p {
		case PathRight:
			return PathDown
		case PathDown:
			return PathRight
		case PathLeft:
			return PathUp
		case PathUp:
			return PathRight
		}
	case "L":
		switch p {
		case PathRight:
			return PathUp
		case PathUp:
			return PathLeft
		case PathLeft:
			return PathDown
		case PathDown:
			return PathRight
		}
	}
	panic(fmt.Errorf("invalid direction: %s", d))
}

type PathInstruction struct {
	Direction PathDirection
	Count     int
}

// Parse

func parseInputDay22(input string) (nums [][]int, instructions []PathInstruction) {
	s := strings.Split(input, "\n\n")
	if len(s) == 2 {
		nums = parse2DMapDay22(s[0])
		instructions = parseInstructionsDay22(s[1])
	}
	return
}

func parse2DMapDay22(input string) [][]int {
	var map2D [][]int
	s := strings.Split(input, "\n")
	var maxWidth int
	for _, l := range s {
		maxWidth = utility.MaxInt(maxWidth, len(l))
	}
	for y, l := range s {
		map2D = append(map2D, make([]int, maxWidth))
		for x := 0; x < maxWidth; x++ {
			map2D[y][x] = 0
			if len(l) > x {
				switch l[x] {
				case ' ':
					map2D[y][x] = 0
				case '.':
					map2D[y][x] = 1
				case '#':
					map2D[y][x] = 2
				}
			}
		}
	}
	return map2D
}

func parseInstructionsDay22(input string) []PathInstruction {
	var instructions []PathInstruction
	input = "R" + input
	regex := regexp.MustCompile(`(L|R)(\d+)`)
	d := PathUp

	for _, instruction := range regex.FindAllStringSubmatch(input, -1) {
		if len(instruction) != 3 {
			continue
		}
		d = d.turn(instruction[1])
		c, err := strconv.Atoi(instruction[2])
		if err != nil {
			continue
		}
		instructions = append(instructions, PathInstruction{d, c})
	}
	return instructions
}

// Solve

func solveDay22Part1(input string) int {
	return -1 // TODO
}

func solveDay22Part2(input string) int {
	return -1 // TODO
}

// Helpers
