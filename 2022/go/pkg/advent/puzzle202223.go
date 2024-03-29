package advent

import (
	"fmt"
	"image"
	"math"
	"regexp"
	"strings"

	"github.com/cgravolet/adventofcode2022/pkg/utility"
)

func (a *AdventOfCode2022) Puzzle202223(input string) {
	part1 := solvePuzzle202223Part1(input)
	part2 := solvePuzzle202223Part2(input)
	fmt.Printf("Part 1: %d\n", part1)
	fmt.Printf("Part 2: %d\n", part2)
}

// Data structures

type CompassDirection int

const (
	North CompassDirection = iota
	South
	West
	East
)

type ElfMap struct {
	grid map[image.Point]bool
}

func (em *ElfMap) AddElf(x, y int) {
	(*em).grid[image.Point{x, y}] = true
}

func (em ElfMap) Description() string {
	minX, maxX, minY, maxY := math.MaxInt, math.MinInt, math.MaxInt, math.MinInt
	for pos := range em.grid {
		minX = utility.MinInt(minX, pos.X)
		maxX = utility.MaxInt(maxX, pos.X)
		minY = utility.MinInt(minY, pos.Y)
		maxY = utility.MaxInt(maxY, pos.Y)
	}
	var desc string
	for y := minY; y <= maxY; y++ {
		for x := minX; x <= maxX; x++ {
			if em.GetElf(x, y) {
				desc += "#"
			} else {
				desc += "."
			}
		}
		desc += "\n"
	}
	return desc
}

func (em ElfMap) Print() {
	fmt.Println(em.Description())
}

func (em ElfMap) GetElf(x, y int) bool {
	val, ok := em.grid[image.Point{x, y}]
	return ok && val
}

func (em ElfMap) GetProposedPosition(index, x, y int) (image.Point, error) {
	p := image.Point{x, y}
	n := em.GetElf(x, y-1)
	s := em.GetElf(x, y+1)
	w := em.GetElf(x-1, y)
	e := em.GetElf(x+1, y)
	nw := em.GetElf(x-1, y-1)
	ne := em.GetElf(x+1, y-1)
	sw := em.GetElf(x-1, y+1)
	se := em.GetElf(x+1, y+1)

	if !(n || nw || ne || s || sw || se || w || e) {
		return p, fmt.Errorf("staying put")
	}

	for i := index; i < index+4; i++ {
		direction := CompassDirection(i % 4)

		switch direction {
		case North:
			if !(n || nw || ne) {
				return p.Add(image.Point{0, -1}), nil
			}
		case South:
			if !(s || sw || se) {
				return p.Add(image.Point{0, 1}), nil
			}
		case West:
			if !(w || nw || sw) {
				return p.Add(image.Point{-1, 0}), nil
			}
		case East:
			if !(e || ne || se) {
				return p.Add(image.Point{1, 0}), nil
			}
		}
	}
	return p, fmt.Errorf("cannot move")
}

func (em *ElfMap) PerformCycle(i int) int {
	proposals := make(map[image.Point]image.Point)
	conflicts := make(map[image.Point]int)

	for elf := range (*em).grid {
		p, err := (*em).GetProposedPosition(i, elf.X, elf.Y)
		if err != nil {
			continue
		}
		_, conflict := proposals[p]
		if conflict {
			conflicts[p] = conflicts[p] + 1
		}
		proposals[p] = elf
	}
	var moves int

	for to, from := range proposals {
		_, conflict := conflicts[to]
		if conflict {
			continue
		}
		(*em).RemoveElf(from.X, from.Y)
		(*em).AddElf(to.X, to.Y)
		moves++
	}
	return moves
}

func (em *ElfMap) RemoveElf(x, y int) {
	delete((*em).grid, image.Point{x, y})
}

func NewElfMap() ElfMap {
	return ElfMap{
		grid: make(map[image.Point]bool),
	}
}

// Parse

func parseInputPuzzle202223(input string) ElfMap {
	em := NewElfMap()
	for y, line := range strings.Split(strings.TrimSpace(input), "\n") {
		for x, r := range line {
			if r == '#' {
				em.AddElf(x, y)
			}
		}
	}
	return em
}

// Solve

func solvePuzzle202223Part1(input string) int {
	em := parseInputPuzzle202223(input)
	for i := 0; i < 10; i++ {
		em.PerformCycle(i)
	}
	re := regexp.MustCompile(`[^.]+`)
	return len(re.ReplaceAllString(em.Description(), ""))
}

func solvePuzzle202223Part2(input string) int {
	em := parseInputPuzzle202223(input)
	i := 0
	for em.PerformCycle(i) != 0 {
		i++
	}
	return i + 1
}
