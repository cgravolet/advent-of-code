package advent

import (
	"fmt"
	"log"
	"strings"

	"github.com/cgravolet/adventofcode2022/pkg/utility"
)

// Data structures

type Stack []string

type Instruction struct {
	Count int
	From  int
	To    int
}

// Program lifecycle

func Day05(input string) {
	stacks := make([]Stack, 9)
	instructions := make([]Instruction, 0)

	err := utility.ForEachLineInReader(strings.NewReader(input), func(s string) {
		if strings.Contains(s, "[") {
			positionCrates(s, stacks)
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

	// Part 1
	part1 := applyInstructions(stacks, instructions)
	fmt.Printf("Day 5, part 1 answer: %s\n", part1)

	// Part 2
	part2 := applyModifiedInstructions(stacks, instructions)
	fmt.Printf("Day 5, part 2 answer: %s\n", part2)
}

// Private methods

func applyInstructions(s []Stack, instructions []Instruction) string {
	stacks := make([]Stack, 0)

	for _, stack := range s {
		newStack := make(Stack, len(stack))
		copy(newStack, stack)
		stacks = append(stacks, newStack)
	}

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
	return getAnswer(stacks)
}

func applyModifiedInstructions(s []Stack, instructions []Instruction) string {
	stacks := make([]Stack, 0)

	for _, stack := range s {
		newStack := make(Stack, len(stack))
		copy(newStack, stack)
		stacks = append(stacks, newStack)
	}

	for _, i := range instructions {
		var x Stack
		x, stacks[i.From] = stacks[i.From][len(stacks[i.From])-i.Count:], stacks[i.From][:len(stacks[i.From])-i.Count]
		stacks[i.To] = append(stacks[i.To], x...)
	}
	return getAnswer(stacks)
}

func getAnswer(st []Stack) string {
	var answer string
	for _, stack := range st {
		if len(stack) > 0 {
			answer += stack[len(stack)-1]
		}
	}
	return answer
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

func positionCrates(s string, st []Stack) {
	i := strings.IndexRune(s, '[')
	si := 0

	for i > -1 {
		si += i / 4
		crate := s[i+1 : i+2]
		st[si] = append(Stack{crate}, st[si]...)

		if len(s) < i+4 {
			i = -1
			continue
		}
		s = s[i+4:]
		i = strings.IndexRune(s, '[')
		si += 1
	}
}
