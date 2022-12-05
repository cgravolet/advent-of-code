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

	// Part 1
	var answer1 string
	part1 := applyInstructions(stacks, instructions)

	for _, stack := range part1 {
		if len(stack) > 0 {
			answer1 += stack[len(stack)-1]
		}
	}
	fmt.Printf("Day 5, part 1 answer: %s\n", answer1)

	// Part 2
	var answer2 string
	part2 := applyModifiedInstructions(stacks, instructions)

	for _, stack := range part2 {
		if len(stack) > 0 {
			answer2 += stack[len(stack)-1]
		}
	}
	fmt.Printf("Day 5, part 2 answer: %s\n", answer2)
}

// Private methods

func applyInstructions(s []Stack, instructions []Instruction) []Stack {
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
	return stacks
}

func applyModifiedInstructions(s []Stack, instructions []Instruction) []Stack {
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
	return stacks
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
