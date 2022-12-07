package main

import (
	"bytes"
	"flag"
	"fmt"
	"log"
	"os"

	"github.com/cgravolet/adventofcode2022/pkg/advent"
)

type AdventCmd struct {
	FlagSet *flag.FlagSet
	Input   *string
}

func main() {
	cmds := make(map[string]AdventCmd)

	for _, cmd := range []string{"day01", "day02", "day03", "day04", "day05", "day06"} {
		flagSet := flag.NewFlagSet(cmd, flag.ExitOnError)
		input := flagSet.String("path", fmt.Sprintf("../../input/%s.txt", cmd), "Path to input file")
		cmds[cmd] = AdventCmd{flagSet, input}
	}
	cmd := cmds[os.Args[1]]
	cmd.FlagSet.Parse(os.Args[2:])
	file, err := os.Open(*cmd.Input)

	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()
	buf := new(bytes.Buffer)
	buf.ReadFrom(file)
	contents := buf.String()

	switch os.Args[1] {
	case "day01":
		advent.Day01(contents)
	case "day02":
		advent.Day02(contents)
	case "day03":
		advent.Day03(contents)
	case "day04":
		advent.Day04(contents)
	case "day05":
		advent.Day05(contents)
	case "day06":
		advent.Day06(contents)
	default:
		log.Fatal(fmt.Errorf("Unexpected argument: %v", os.Args[1]))
	}
}
