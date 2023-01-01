package advent

import (
	"fmt"
	"image"
	"math"
	"strings"

	"github.com/cgravolet/adventofcode2022/pkg/utility"
)

func (a *AdventOfCode2022) Day23(input string) {
	part1 := solveDay23Part1(input)
	fmt.Printf("Part 1: %d\n", part1)
}

// Data structures

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

func (em *ElfMap) GetElf(x, y int) bool {
	val, ok := (*em).grid[image.Point{x, y}]
	return ok && val
}

func (em ElfMap) GetElves() (e []image.Point) {
	for key := range em.grid {
		e = append(e, key)
	}
	return
}

func (em ElfMap) GetEmptySpaceCount() int {
	minX, maxX, minY, maxY := math.MaxInt, math.MinInt, math.MaxInt, math.MinInt
	for pos := range em.grid {
		minX = utility.MinInt(minX, pos.X)
		maxX = utility.MaxInt(maxX, pos.X)
		minY = utility.MinInt(minY, pos.Y)
		maxY = utility.MaxInt(maxY, pos.Y)
	}
	var sum int
	for x := minX; x <= maxX; x++ {
		for y := minY; y <= maxY; y++ {
			if !em.GetElf(x, y) {
				sum++
			}
		}
	}
	return sum
}

func (em ElfMap) GetProposedPosition(x, y int) (image.Point, error) {
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
	} else if !(n || nw || ne) {
		return p.Add(image.Point{0, -1}), nil
	} else if !(s || sw || se) {
		return p.Add(image.Point{0, 1}), nil
	} else if !(w || nw || sw) {
		return p.Add(image.Point{-1, 0}), nil
	} else if !(e || ne || se) {
		return p.Add(image.Point{1, 0}), nil
	}
	return p, fmt.Errorf("cannot move")
}

func (em *ElfMap) PerformCycle() {
	proposals := make(map[image.Point]image.Point)
	conflicts := make(map[image.Point]int)

	for elf := range (*em).grid {
		p, err := (*em).GetProposedPosition(elf.X, elf.Y)
		if err != nil {
			continue
		}
		_, conflict := proposals[p]
		if conflict {
			conflicts[p] = conflicts[p] + 1
		}
		proposals[p] = elf
	}

	for to, from := range proposals {
		_, conflict := conflicts[to]
		if conflict {
			continue
		}
		(*em).RemoveElf(from.X, from.Y)
		(*em).AddElf(to.X, to.Y)
	}
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

func parseInputDay23(input string) ElfMap {
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

func solveDay23Part1(input string) int {
	em := parseInputDay23(input)
	fmt.Printf("== Initial State ==\n")
	em.Print()

	for i := 0; i < 10; i++ {
		em.PerformCycle()
		fmt.Printf("\n== End of Round %d ==\n", i+1)
		em.Print()
	}
	return em.GetEmptySpaceCount()
}
