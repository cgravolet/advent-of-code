package advent

import (
	"fmt"
	"io"
	"log"
	"strings"

	"github.com/cgravolet/adventofcode2022/pkg/utility"
)

type Line string
type Shape int
type Outcome int

const (
	Rock     Shape = 1
	Paper          = 2
	Scissors       = 3
)

const (
	Win  Outcome = 6
	Draw         = 3
	Loss         = 0
)

func (lhs Shape) Play(rhs Shape) Outcome {
	var outcome Outcome
	switch lhs {
	case Rock:
		switch rhs {
		case Rock:
			outcome = Draw
		case Paper:
			outcome = Win
		case Scissors:
			outcome = Loss
		}
	case Paper:
		switch rhs {
		case Rock:
			outcome = Loss
		case Paper:
			outcome = Draw
		case Scissors:
			outcome = Win
		}
	case Scissors:
		switch rhs {
		case Rock:
			outcome = Win
		case Paper:
			outcome = Loss
		case Scissors:
			outcome = Draw
		}
	}
	return outcome
}

func (lhs Shape) Score(rhs Shape) int {
	return int(lhs.Play(rhs)) + int(rhs)
}

func (lhs Shape) ScoreWithDesiredOutcome(o Outcome) int {
	if lhs.Play(Rock) == o {
		return lhs.Score(Rock)
	} else if lhs.Play(Paper) == o {
		return lhs.Score(Paper)
	} else if lhs.Play(Scissors) == o {
		return lhs.Score(Scissors)
	}
	return 0
}

func (l Line) ToOutcome() Outcome {
	switch l {
	case "X":
		return Loss
	case "Y":
		return Draw
	case "Z":
		return Win
	default:
		return 0
	}
}

func (l Line) ToShape() Shape {
	switch l {
	case "A", "X":
		return Rock
	case "B", "Y":
		return Paper
	case "C", "Z":
		return Scissors
	default:
		return 0
	}
}

func Day02(input string) {
	day02part1(strings.NewReader(input))
	day02part2(strings.NewReader(input))
}

func day02part1(input io.Reader) {
	scoreTotal := 0
	err := utility.ForEachLineInFile(input, func(s string) {
		inputs := utility.Map(strings.Split(s, " "), func(i string) Shape {
			return Line(i).ToShape()
		})
		if len(inputs) < 2 {
			return
		}
		scoreTotal += inputs[0].Score(inputs[1])
	})

	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("Total score (part 1): %d\n", scoreTotal)
}

func day02part2(input io.Reader) {
	scoreTotal := 0
	err := utility.ForEachLineInFile(input, func(s string) {
		inputs := strings.Split(s, " ")
		if len(inputs) < 2 {
			return
		}
		shape := Line(inputs[0]).ToShape()
		outcome := Line(inputs[1]).ToOutcome()
		scoreTotal += shape.ScoreWithDesiredOutcome(outcome)
	})

	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("Total score (part 2): %d\n", scoreTotal)
}
