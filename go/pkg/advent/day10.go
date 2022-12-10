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

func Day10(input string) {
	instructions := makeClockCircuitInstructions(strings.NewReader(input))
	part1, part2 := day10part1(instructions)
	fmt.Printf("Part 1: %d\n", part1)
	fmt.Printf("%s\n", part2)
}

// Internal methods

func day10part1(in []ClockCircuitInstruction) (int, string) {
	x := 1
	strength := []int{0}
	pixels := make([]string, 0)
	pos := 0

	for len(in) > 0 {
		cycle := len(strength)
		strength = append(strength, x*cycle)

		// Draw the pixel
		pixel := "."
		if pos >= x-1 && pos <= x+1 {
			pixel = "#"
		}
		pixels = append(pixels, pixel)
		pos++

		// Reset position if this is end of the CRT's draw distance
		if pos%40 == 0 {
			pixels = append(pixels, "\n")
			pos = 0
		}

		// Apply clock circuit instruction to move the register
		in[0].Cycles -= 1
		if in[0].Cycles <= 0 {
			x += in[0].Value
			in = in[1:]
		}
	}

	// Sum of signal strength duyring the 20th, 60th, 100th, 140th, 180th, and 220th cycles
	sum := 0
	for i := 20; i <= 220; i += 40 {
		sum += strength[i]
	}
	return sum, strings.Join(pixels, "")
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
