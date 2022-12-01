package utility

import (
	"bufio"
	"os"
)

func ReadLinesFromFile(path string) ([]string, error) {
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
