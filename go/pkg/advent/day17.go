package advent

import (
	"fmt"
	"image"
	"strings"

	"github.com/cgravolet/adventofcode2022/pkg/utility"
)

func (a *AdventOfCode2022) Day17(input string) {
	part1 := solveDay17Part1(input)
	part2 := solveDay17Part2(input)
	fmt.Printf("Part 1: %d\n", part1)
	fmt.Printf("Part 2: %d\n", part2)
}

// Data structures

type RockShape []image.Point

func (rs *RockShape) Len() int {
	return 5
}

func (rs *RockShape) Move(x, y int) RockShape {
	var rock RockShape
	for _, p := range *rs {
		rock = append(rock, image.Point{p.X + x, p.Y + y})
	}
	return rock
}

func NewRockShape(index int, y int) (shape RockShape, i int) {
	i = index % shape.Len()
	switch i {
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
		panic(fmt.Errorf("retrieving shape for invalid range %d", i))
	}
	return
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

func (rc *RockChamber) GetTopRows(count int) string {
	row, max := "", rc.GetHeight()-1

	for y := max; y >= max-count; y-- {
		for x := 0; x < 7; x++ {
			_, exists := (*rc)[image.Point{x, y}]
			if exists {
				row += "#"
			} else {
				row += "."
			}
		}
	}
	return row
}

// Solve

func solveDay17Part1(input string) int {
	rockCount := 2022
	chamber := make(RockChamber)
	jets := strings.TrimSpace(input)
	j, y := 0, 3

	for i := 0; i < rockCount; i++ {
		rock, _ := NewRockShape(i, y)

		for {
			// Determine what direction the steam is blowing
			var jx int
			if jets[j%len(jets)] == '<' {
				jx = -1
			} else if jets[j%len(jets)] == '>' {
				jx = 1
			}
			j++

			// Move the rock left or right depending on direction os steam
			if !chamber.Collides(rock.Move(jx, 0)) {
				rock = rock.Move(jx, 0)
			}

			// Move down
			if chamber.Collides(rock.Move(0, -1)) {
				chamber.AddRock(rock)
				y = chamber.GetHeight() + 3
				break
			} else {
				rock = rock.Move(0, -1)
			}
		}
	}
	return chamber.GetHeight()
}

func solveDay17Part2(input string) int {
	rockCount := 1000000000000
	chamber := make(RockChamber)
	jets := strings.TrimSpace(input)
	j, y := 0, 3

	type cycle struct {
		r, j int
		t    string
	}
	type cycleVal struct {
		h, i int
	}
	cache := make(map[cycle]cycleVal)
	heightBeforeTotal := 0
	totalHeightWithoutRemainder := 0

	for i := 0; i < rockCount; i++ {
		rock, r := NewRockShape(i, y)
		c := cycle{r, j % len(jets), chamber.GetTopRows(100)}
		height := chamber.GetHeight()
		val, exists := cache[c]

		// If a cycle is detected, the number of cycles and total height can be calculated and the majority
		// of iterations can be skipped
		if exists && totalHeightWithoutRemainder == 0 {
			rocksPerCycle := i - 1 - val.i
			heightPerCycle := height - val.h
			numberOfCycles := (rockCount - val.i) / rocksPerCycle
			totalHeightWithoutRemainder = val.h + (numberOfCycles * heightPerCycle)
			heightBeforeTotal = height

			// Increment i to drop remainder of rocks after cycle calculation
			i = rockCount - (rockCount - val.i - (numberOfCycles * rocksPerCycle))
			continue
		}
		cache[c] = cycleVal{height, i - 1}

		for {
			jx := 1
			if jets[j%len(jets)] == '<' {
				jx = -1
			}
			j++

			if !chamber.Collides(rock.Move(jx, 0)) {
				rock = rock.Move(jx, 0)
			}

			if chamber.Collides(rock.Move(0, -1)) {
				chamber.AddRock(rock)
				y = chamber.GetHeight() + 3
				break
			} else {
				rock = rock.Move(0, -1)
			}
		}
	}
	return chamber.GetHeight() - heightBeforeTotal + totalHeightWithoutRemainder
}
