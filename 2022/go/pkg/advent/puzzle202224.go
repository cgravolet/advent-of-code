package advent

import (
	"fmt"
	"image"
	"strings"
)

func (a *AdventOfCode2022) Puzzle202224(input string) {
	part1 := solvePuzzle202224Part1(input)
	part2 := solvePuzzle202224Part2(input)
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

func (m Mountain) Description() string {
	var desc string
	for _, row := range m.valley {
		for _, e := range row {
			if e&wall > 0 {
				desc += "#"
			} else if e == 0 {
				desc += "."
			} else {
				count := 0
				blizz := ""

				if e&blizzNorth > 0 {
					blizz = "^"
					count++
				}
				if e&blizzSouth > 0 {
					blizz = "v"
					count++
				}
				if e&blizzWest > 0 {
					blizz = "<"
					count++
				}
				if e&blizzEast > 0 {
					blizz = ">"
					count++
				}
				if count > 1 {
					desc += fmt.Sprintf("%d", count)
				} else {
					desc += blizz
				}
			}
		}
		desc += "\n"
	}
	return strings.TrimSpace(desc)
}

func (m Mountain) IncrementTime() Mountain {
	mountain := Mountain{start: m.start, end: m.end, valley: make([][]valleyEntity, len(m.valley))}
	blizzards := make(map[image.Point]valleyEntity)

	for y, row := range m.valley {
		mountain.valley[y] = make([]valleyEntity, len(row))
		for x, entity := range row {
			if entity&wall > 0 {
				mountain.valley[y][x] = entity
				continue
			}
			if entity&blizzNorth > 0 {
				pos := image.Point{x, y - 1}
				if m.valley[pos.Y][pos.X]&wall > 0 {
					pos = image.Point{x, len(m.valley) - 2}
				}
				blizzards[pos] |= blizzNorth
			}
			if entity&blizzSouth > 0 {
				pos := image.Point{x, y + 1}
				if m.valley[pos.Y][pos.X]&wall > 0 {
					pos = image.Point{x, 1}
				}
				blizzards[pos] |= blizzSouth
			}
			if entity&blizzWest > 0 {
				pos := image.Point{x - 1, y}
				if m.valley[pos.Y][pos.X]&wall > 0 {
					pos = image.Point{len(row) - 2, y}
				}
				blizzards[pos] |= blizzWest
			}
			if entity&blizzEast > 0 {
				pos := image.Point{x + 1, y}
				if m.valley[pos.Y][pos.X]&wall > 0 {
					pos = image.Point{1, y}
				}
				blizzards[pos] |= blizzEast
			}
		}
	}

	for point, blizz := range blizzards {
		mountain.valley[point.Y][point.X] |= blizz
	}
	return mountain
}

// Parse

func parseInputPuzzle202224(input string) Mountain {
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

func solvePuzzle202224Part1(input string) int {
	m := parseInputPuzzle202224(input)
	_, time := findPath(m)
	return time
}

func solvePuzzle202224Part2(input string) int {
	var sum int
	m := parseInputPuzzle202224(input)
	nm, time := findPath(m)
	sum += time
	nm.start = m.end
	nm.end = m.start
	nm, time = findPath(nm)
	sum += time
	nm.start = m.start
	nm.end = m.end
	nm, time = findPath(nm)
	sum += time
	return sum
}

// Helpers

func findPath(m Mountain) (Mountain, int) {
	type snapshot struct {
		position image.Point
		mountain Mountain
		time     int
	}
	q := []snapshot{{m.start, m, 0}}
	cache := make(map[string]bool)

	for len(q) > 0 {
		s := q[0]
		q = q[1:]

		if s.position == m.end {
			return s.mountain, s.time
		}
		_, exists := cache[fmt.Sprintf("%v-%d", s.position, s.time)]

		if exists {
			continue
		} else {
			cache[fmt.Sprintf("%v-%d", s.position, s.time)] = true
		}
		nm := s.mountain.IncrementTime()
		north := s.position.Add(image.Point{0, -1})
		south := s.position.Add(image.Point{0, 1})
		east := s.position.Add(image.Point{1, 0})
		west := s.position.Add(image.Point{-1, 0})

		if north.Y >= 0 && nm.valley[north.Y][north.X] == 0 {
			q = append(q, snapshot{north, nm, s.time + 1})
		}

		if south.Y < len(nm.valley) && nm.valley[south.Y][south.X] == 0 {
			q = append(q, snapshot{south, nm, s.time + 1})
		}

		if nm.valley[east.Y][east.X] == 0 {
			q = append(q, snapshot{east, nm, s.time + 1})
		}

		if nm.valley[west.Y][west.X] == 0 {
			q = append(q, snapshot{west, nm, s.time + 1})
		}

		if nm.valley[s.position.Y][s.position.X] == 0 {
			q = append(q, snapshot{s.position, nm, s.time + 1})
		}
	}
	return m, -1
}
