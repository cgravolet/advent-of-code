package main

import (
	"bytes"
	"flag"
	"fmt"
	"log"
	"os"
	"strings"

	"github.com/cgravolet/adventofcode2022/pkg/advent"
)

func main() {
	if len(os.Args) < 2 {
		log.Fatal(fmt.Errorf("You must specify a subcommand (i.e. 'day01' or 'day02')"))
	}
	subcmd := os.Args[1]
	flagSet := flag.NewFlagSet(subcmd, flag.ExitOnError)
	input := flagSet.String("path", fmt.Sprintf("../../input/%s.txt", subcmd), "Input file path")
	flagSet.Parse(os.Args[2:])
	file, err := os.Open(*input)

	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()
	buf := new(bytes.Buffer)
	buf.ReadFrom(file)
	contents := buf.String()

	switch strings.ToLower(subcmd) {
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
	case "day07":
		advent.Day07(contents)
	default:
		log.Fatal(fmt.Errorf("Unexpected argument: %v", os.Args[1]))
	}
}
