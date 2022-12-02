package main

import (
	"fmt"
	"log"
	"os"
	"strings"

	"github.comcast.com/cgravo558/advent2022/pkg/utility"
)

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

func main() {
	lines, err := utility.ReadLinesFromFile(os.Args)

	if err != nil {
		log.Fatal(err)
	}
	foo := utility.Map(lines, func(l string) []string {
		return strings.Split(l, " ")
	})
	fmt.Println(foo)
}
