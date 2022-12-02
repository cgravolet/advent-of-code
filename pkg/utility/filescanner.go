package utility

import (
	"bufio"
	"fmt"
	"os"
)

func ReadLinesFromFile(args []string) ([]string, error) {
	if len(args) <= 1 {
		err := fmt.Errorf("Path to input file required")
		return nil, err
	}
	path := os.Args[1]
	return getLinesFromFile(path)
}

func getLinesFromFile(path string) ([]string, error) {
	var lines []string
	file, err := os.Open(path)

	if err != nil {
		return lines, err
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}
	return lines, nil
}
