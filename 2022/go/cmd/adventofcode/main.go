package main

import (
	"bytes"
	"flag"
	"fmt"
	"log"
	"os"
	"path/filepath"
	"reflect"

	"github.com/cgravolet/adventofcode2022/pkg/advent"
)

func main() {
	// Check for sub-command argument (i.e. "2022 01, 2022 02, etc.")
	if len(os.Args) < 3 {
		log.Fatal(fmt.Errorf("you must specify a subcommand (i.e. '2022 01' or '2022 02')"))
	}
	year := os.Args[1]
	day := os.Args[2]
	subcmd := fmt.Sprintf("puzzle%s%s", year, day)

	// Retrieve the input path option, if available
	defaultPath := filepath.Join("..", "..", "..", "..", "input", fmt.Sprintf("%s-%s.txt", year, day))
	flagSet := flag.NewFlagSet(subcmd, flag.ExitOnError)
	input := flagSet.String("path", defaultPath, "Input file path")
	flagSet.Parse(os.Args[3:])

	// Open the input file and read it's contents
	file, err := os.Open(*input)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()
	buf := new(bytes.Buffer)
	buf.ReadFrom(file)
	contents := buf.String()

	// Use reflection to find the function related to the given sub-command, and pass it the contents of the input file
	adv := &advent.AdventOfCode2022{}
	funcName := fmt.Sprintf("Puzzle%s%s", year, day)
	cmdFunc := reflect.ValueOf(adv).MethodByName(funcName)

	if !cmdFunc.IsValid() {
		log.Fatal(fmt.Errorf("method '%s' not found", funcName))
	}
	params := []reflect.Value{reflect.ValueOf(contents)}
	cmdFunc.Call(params)
}
