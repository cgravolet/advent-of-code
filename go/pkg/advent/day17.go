package advent

import (
	"container/ring"
	"fmt"
	"strings"
)

type JetDirection string

const (
	JetLeft  JetDirection = ">"
	JetRight JetDirection = "<"
)

func (a *AdventOfCode2022) Day17(input string) {
	instructions := parseInputDay17(input)
	fmt.Printf("%d %q\n", instructions.Len(), instructions)
}

func parseInputDay17(input string) *ring.Ring {
	input = strings.TrimSpace(input)
	r := ring.New(len(input))
	for _, d := range input {
		r.Value = JetDirection(d)
		r.Next()
	}
	return r
}
