package advent

import (
	"container/ring"
	"fmt"
	"image"
	"strings"

	"github.com/cgravolet/adventofcode2022/pkg/utility"
)

func (a *AdventOfCode2022) Day17(input string) {
	part1 := solveDay17Part1(input)
	fmt.Printf("Part 1: %d\n", part1)
}

// Data structures

type JetDirection string

const (
	JetLeft  JetDirection = "<"
	JetRight JetDirection = ">"
)

type RockShape []image.Point

func (rs *RockShape) move(x, y int) RockShape {
	var rock RockShape
	for _, p := range *rs {
		rock = append(rock, image.Point{p.X + x, p.Y + y})
	}
	return rock
}

func NewRockShape(index int, y int) RockShape {
	var shape RockShape
	switch index % 5 {
	case 0:
		shape = RockShape{{2, y}, {3, y}, {4, y}, {5, y}}
	case 1:
		shape = RockShape{{3, y + 2}, {2, y + 1}, {3, y + 1}, {4, y + 1}, {3, y}}
	case 2:
		shape = RockShape{{4, y + 2}, {4, y + 1}, {2, y}, {3, y}, {4, y}}
	case 3:
		shape = RockShape{{2, y + 3}, {2, y + 2}, {2, y + 1}, {2, y}}
	case 4:
		shape = RockShape{{2, y + 1}, {3, y + 1}, {2, y}, {3, y}}
	default:
		panic(fmt.Errorf("retrieving shape for invalid range %d", index%5))
	}
	return shape
}

type RockChamber map[image.Point]bool

func (rc *RockChamber) AddRock(rock RockShape) {
	for _, p := range rock {
		(*rc)[p] = true
	}
}

func (rc *RockChamber) Collides(points []image.Point) bool {
	for _, p := range points {
		occupied, ok := (*rc)[p]
		if (ok && occupied) || p.Y < 0 || p.X < 0 || p.X > 6 {
			return true
		}
	}
	return false
}

func (rc *RockChamber) Description() string {
	res := ""
	for y := rc.GetHeight(); y >= 0; y-- {
		row := ""
		for x := 0; x < 7; x++ {
			occupied, ok := (*rc)[image.Point{x, y}]
			if occupied && ok {
				row += "#"
			} else {
				row += "."
			}
		}
		res += row
		res += "\n"
	}
	return res
}

func (rc *RockChamber) GetHeight() int {
	var maxY int
	for point := range *rc {
		maxY = utility.MaxInt(maxY, point.Y)
	}
	return maxY + 1
}

// Parse

func parseInputDay17(input string) *ring.Ring {
	input = strings.TrimSpace(input)
	r := ring.New(len(input))
	for _, d := range input {
		r.Value = JetDirection(d)
		r = r.Next()
	}
	return r
}

// Solve

func solveDay17Part1(input string) int {
	chamber := make(RockChamber)
	jets := parseInputDay17(input)
	y := 3

	for i := 0; i < 2022; i++ {
		rock := NewRockShape(i, y)

		for {
			jetx := 1
			if jets.Value == JetLeft {
				jetx = -1
			}
			jets = jets.Next()

			// Move left or right depending on the jet of steam
			if !chamber.Collides(rock.move(jetx, 0)) {
				rock = rock.move(jetx, 0)
			}

			// Move down
			if chamber.Collides(rock.move(0, -1)) {
				chamber.AddRock(rock)
				y = chamber.GetHeight() + 3
				break
			} else {
				rock = rock.move(0, -1)
			}
		}
	}
	return chamber.GetHeight()
}

func solveDay17Part2(input string) int {
	chamber := make(RockChamber)
	jets := parseInputDay17(input)
	y := 3

	for i := 0; i < 1000000000000; i++ {
		rock := NewRockShape(i, y)

		for {
			jetx := 1
			if jets.Value == JetLeft {
				jetx = -1
			}
			jets = jets.Next()

			// Move left or right depending on the jet of steam
			if !chamber.Collides(rock.move(jetx, 0)) {
				rock = rock.move(jetx, 0)
			}

			// Move down
			if chamber.Collides(rock.move(0, -1)) {
				chamber.AddRock(rock)
				y = chamber.GetHeight() + 3
				break
			} else {
				rock = rock.move(0, -1)
			}
		}
	}
	return chamber.GetHeight()
}
