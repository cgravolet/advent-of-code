package main

import (
	"bytes"
	"flag"
	"fmt"
	"log"
	"os"
	"reflect"
	"strings"

	"github.com/cgravolet/adventofcode2022/pkg/advent"
)

func main() {
	// Check for sub-command argument (i.e. "day01, day02, etc.")
	if len(os.Args) < 2 {
		log.Fatal(fmt.Errorf("You must specify a subcommand (i.e. 'day01' or 'day02')"))
	}
	subcmd := os.Args[1]

	// Retrieve the input path option, if available
	flagSet := flag.NewFlagSet(subcmd, flag.ExitOnError)
	input := flagSet.String("path", fmt.Sprintf("../../../input/%s.txt", subcmd), "Input file path")
	flagSet.Parse(os.Args[2:])

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
	funcName := strings.ToUpper(subcmd[:1]) + strings.ToLower(subcmd[1:])
	cmdFunc := reflect.ValueOf(adv).MethodByName(funcName)

	if !cmdFunc.IsValid() {
		log.Fatal(fmt.Errorf("Method '%s' not found", funcName))
	}
	params := []reflect.Value{reflect.ValueOf(contents)}
	cmdFunc.Call(params)
}
