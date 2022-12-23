package advent

import (
	"fmt"
	"strings"
)

func (a *AdventOfCode2022) Day23(input string) {
	part1 := solveDay23Part1(input)
	fmt.Printf("Part 1: %d\n", part1)
}

// Data structures

type ElfMap struct {
	MinX, MaxX, MinY, MaxY int
	grid                   map[int]map[int]bool
}

func (em *ElfMap) AddElf(x, y int) {
	_, xok := (*em).grid[x]
	if !xok {
		(*em).grid[x] = make(map[int]bool)
	}
	(*em).grid[x][y] = true
}

func (em *ElfMap) Description() string {
	return "" // TODO
}

func (em *ElfMap) GetElf(x, y int) bool {
	val, ok := (*em).grid[x][y]
	return ok && val
}

func (em *ElfMap) Print() {
	fmt.Printf("\n%s\n", em.Description())
}

func (em *ElfMap) RemoveElf(x, y int) {
	_, xok := (*em).grid[x]
	if !xok {
		(*em).grid[x] = make(map[int]bool)
	}
	delete((*em).grid[x], y)
}

func NewElfMap() ElfMap {
	return ElfMap{
		grid: make(map[int]map[int]bool),
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
	fmt.Printf("Elf Map:\n%v\n", em)
	return -1
}
