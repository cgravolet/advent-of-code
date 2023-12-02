package advent

import (
	"fmt"
	"image"
	"regexp"
	"strconv"
	"strings"

	"github.com/cgravolet/adventofcode2022/pkg/utility"
)

func (a *AdventOfCode2022) Puzzle202222(input string) {
	part1 := solvePuzzle202222Part1(input)
	part2 := solvePuzzle202222Part2(input)
	fmt.Printf("Part 1: %d\n", part1)
	fmt.Printf("Part 2: %d\n", part2)
}

// Data structures

type BoardMap [][]int

func (m BoardMap) Move(p image.Point, d PathDirection) (image.Point, error) {
	var pos image.Point
	err := fmt.Errorf("direction not implemented: %d", d)

	switch d {
	case PathUp:
		pos, err = m.moveVertical(-1, p)
	case PathDown:
		pos, err = m.moveVertical(1, p)
	case PathLeft:
		pos, err = m.moveHorizontal(-1, p)
	case PathRight:
		pos, err = m.moveHorizontal(1, p)
	}
	return pos, err
}

func (m BoardMap) moveVertical(d int, p image.Point) (image.Point, error) {
	pos := p.Add(image.Point{0, d})

	if d > 0 && (pos.Y >= len(m) || m[pos.Y][pos.X] == 0) {
		// Move up until 0 is found
		for {
			cur := pos.Add(image.Point{0, -1})
			if cur.Y < 0 || m[cur.Y][cur.X] == 0 {
				break
			} else {
				pos = cur
			}
		}
	} else if d < 0 && (pos.Y < 0 || m[pos.Y][pos.X] == 0) {
		// Move down until 0 is found
		for {
			cur := pos.Add(image.Point{0, 1})
			if cur.Y >= len(m) || m[cur.Y][cur.X] == 0 {
				break
			} else {
				pos = cur
			}
		}
	}

	if m[pos.Y][pos.X] == 2 {
		return p, fmt.Errorf("wall detected")
	}
	return pos, nil
}

func (m BoardMap) moveHorizontal(d int, p image.Point) (image.Point, error) {
	pos := p.Add(image.Point{d, 0})

	if d > 0 && (pos.X >= len(m[pos.Y]) || m[pos.Y][pos.X] == 0) {
		// Move left until 0 is found
		for {
			cur := pos.Add(image.Point{-1, 0})
			if cur.X < 0 || m[cur.Y][cur.X] == 0 {
				break
			} else {
				pos = cur
			}
		}
	} else if d < 0 && (pos.X < 0 || m[pos.Y][pos.X] == 0) {
		// Move right until 0 is found
		for {
			cur := pos.Add(image.Point{1, 0})
			if cur.X >= len(m[cur.Y]) || m[cur.Y][cur.X] == 0 {
				break
			} else {
				pos = cur
			}
		}
	}

	if m[pos.Y][pos.X] == 2 {
		return p, fmt.Errorf("wall detected")
	}
	return pos, nil
}

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
			return PathLeft
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

func parseInputPuzzle202222(input string) (board BoardMap, start image.Point, instructions []PathInstruction) {
	s := strings.Split(input, "\n\n")
	if len(s) == 2 {
		board, start = parseBoardMap22(s[0])
		instructions = parseInstructionsPuzzle202222(s[1])
	}
	return
}

func parseBoardMap22(input string) (BoardMap, image.Point) {
	var board BoardMap
	var maxWidth int
	var start *image.Point
	lines := strings.Split(input, "\n")
	for _, l := range lines {
		maxWidth = utility.MaxInt(maxWidth, len(l))
	}
	for y, l := range lines {
		board = append(board, make([]int, maxWidth))
		for x := 0; x < maxWidth; x++ {
			board[y][x] = 0
			if len(l) > x {
				switch l[x] {
				case ' ':
					board[y][x] = 0
				case '.':
					if start == nil {
						start = &image.Point{x, y}
					}
					board[y][x] = 1
				case '#':
					board[y][x] = 2
				}
			}
		}
	}
	return board, *start
}

func parseInstructionsPuzzle202222(input string) []PathInstruction {
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

func solvePuzzle202222Part1(input string) int {
	board, pos, instructions := parseInputPuzzle202222(input)
	dir := PathUp

	for _, instruction := range instructions {
		dir = instruction.Direction

		for i := 0; i < instruction.Count; i++ {
			p, err := board.Move(pos, instruction.Direction)
			if err != nil {
				break
			}
			pos = p
		}
	}
	return calculatePassword(pos, dir)
}

func solvePuzzle202222Part2(input string) int {
	return -1 // TODO
}

// Helpers

func calculatePassword(pos image.Point, dir PathDirection) int {
	return 1000*(pos.Y+1) + 4*(pos.X+1) + int(dir)
}
