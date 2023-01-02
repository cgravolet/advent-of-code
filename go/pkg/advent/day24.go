package advent

import (
	"fmt"
	"image"
	"strings"
)

func (a *AdventOfCode2022) Day24(input string) {
	part1 := solveDay24Part1(input)
	part2 := solveDay24Part2(input)
	fmt.Printf("Part 1: %d\n", part1)
	fmt.Printf("Part 2: %d\n", part2)
}

// Data structures

type valleyEntity uint8

const (
	empty      valleyEntity = 0
	player     valleyEntity = 1 << 0
	blizzNorth valleyEntity = 1 << 3
	blizzEast  valleyEntity = 1 << 4
	blizzSouth valleyEntity = 1 << 5
	blizzWest  valleyEntity = 1 << 6
	wall       valleyEntity = 1 << 7
)

type Mountain struct {
	start  image.Point
	end    image.Point
	valley [][]valleyEntity
}

// Parse

func parseInputDay24(input string) Mountain {
	var s, e *image.Point
	lines := strings.Split(strings.TrimSpace(input), "\n")
	m := Mountain{
		valley: make([][]valleyEntity, len(lines)),
	}

	for y, line := range lines {
		m.valley[y] = make([]valleyEntity, len(line))

		for x, r := range line {
			switch r {
			case '#':
				m.valley[y][x] = wall
			case '^':
				m.valley[y][x] = blizzNorth
			case '>':
				m.valley[y][x] = blizzEast
			case 'v':
				m.valley[y][x] = blizzSouth
			case '<':
				m.valley[y][x] = blizzWest
			case '.':
				if s == nil {
					s = &image.Point{x, y}
				} else {
					e = &image.Point{x, y}
				}
				m.valley[y][x] = empty
			}
		}
	}
	m.start, m.end = *s, *e
	return m
}

// Solve

func solveDay24Part1(input string) int {
	return -1 // TODO
}

func solveDay24Part2(input string) int {
	return -1 // TODO
}
