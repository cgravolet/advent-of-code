package advent

import (
	"fmt"
	"io"
	"log"
	"strconv"
	"strings"

	"github.com/cgravolet/adventofcode2022/pkg/utility"
)

type ClockCircuitInstruction struct {
	Cycles int
	Value  int
}

func (a *AdventOfCode2022) Day10(input string) {
	instructions := makeClockCircuitInstructions(strings.NewReader(input))
	part1, part2 := day10part1(instructions)
	fmt.Printf("Part 1: %d\n", part1)
	fmt.Printf("%s\n", part2)
}

// Internal methods

func day10part1(in []ClockCircuitInstruction) (int, string) {
	cycle, x, pos, sum, pixels := 1, 1, 0, 0, ""

	for len(in) > 0 {
		if (cycle-20)%40 == 0 {
			sum += x * cycle
		}

		// Draw the pixel
		if pos >= x-1 && pos <= x+1 {
			pixels += "#"
		} else {
			pixels += "."
		}
		pos++

		// Reset position if this is end of the CRT's draw distance
		if pos%40 == 0 {
			pixels += "\n"
			pos = 0
		}

		// Apply clock circuit instruction to move the register
		in[0].Cycles -= 1
		if in[0].Cycles <= 0 {
			x += in[0].Value
			in = in[1:]
		}
		cycle++
	}
	return sum, pixels
}

func makeClockCircuitInstructions(r io.Reader) []ClockCircuitInstruction {
	instructions := make([]ClockCircuitInstruction, 0)

	err := utility.ForEachLineInReader(r, func(s string) {
		components := strings.Split(s, " ")
		if len(components) > 0 {
			switch components[0] {
			case "noop":
				instructions = append(instructions, ClockCircuitInstruction{1, 0})
			case "addx":
				if len(components) == 2 {
					value, err := strconv.Atoi(components[1])
					if err == nil {
						instructions = append(instructions, ClockCircuitInstruction{2, value})
					}
				}
			}
		}
	})

	if err != nil {
		log.Fatal(err)
	}
	return instructions
}
