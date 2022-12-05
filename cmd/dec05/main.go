package main

import (
	"fmt"
	"log"
	"os"
	"strings"

	"github.comcast.com/cgravo558/advent2022/pkg/utility"
)

// Data structures

type Stack []string

type Instruction struct {
	Count int
	From  int
	To    int
}

// Program lifecycle

func main() {
	stacks := make([]Stack, 9)
	instructions := make([]Instruction, 0)

	err := utility.ForEachLineInFile(os.Args[1], func(s string) {
		if strings.Contains(s, "[") {
			positionCrates(s, &stacks)
		} else {
			i, err := parseInstructionFromString(s)

			if err == nil {
				instructions = append(instructions, i)
			}
		}
	})

	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("Day 5\nStacks: %v\nInstructions (%d): %v\n", stacks, len(instructions), instructions)

	applyInstructions(instructions, &stacks)
	var answer string

	for _, stack := range stacks {
		if len(stack) > 0 {
			answer += stack[len(stack)-1]
		}
	}
	fmt.Printf("Day 5\nStacks: %v\n\n", stacks)
	fmt.Printf("Day 5, part 1 answer: %s\n", answer)
}

// Private methods

func applyInstructions(instructions []Instruction, s *[]Stack) {
	stacks := *s

	for _, i := range instructions {
		for c := 0; c < i.Count; c++ {
			if len(stacks) <= i.From || len(stacks[i.From]) == 0 {
				continue
			}
			var x string
			x, stacks[i.From] = stacks[i.From][len(stacks[i.From])-1], stacks[i.From][:len(stacks[i.From])-1]
			stacks[i.To] = append(stacks[i.To], x)
		}
	}
	*s = stacks
}

func parseInstructionFromString(s string) (Instruction, error) {
	var i Instruction
	var f int
	var t int
	_, err := fmt.Sscanf(s, "move %d from %d to %d", &i.Count, &f, &t)

	if err != nil {
		return i, err
	}
	i.From = f - 1
	i.To = t - 1
	return i, nil
}

// 0 4 8 12 16 20 24 28 32
func positionCrates(s string, st *[]Stack) {
	stacks := *st
	str := s

	i := strings.IndexRune(str, '[')
	si := 0

	for i > -1 {
		si += i / 4
		crate := str[i+1 : i+2]
		stacks[si] = append(Stack{crate}, stacks[si]...)

		if len(str) < i+4 {
			i = -1
			continue
		}
		str = str[i+4:]
		i = strings.IndexRune(str, '[')
		si += 1
	}
	*st = stacks
}
