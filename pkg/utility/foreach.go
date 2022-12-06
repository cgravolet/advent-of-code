package utility

import (
	"bufio"
	"os"
)

func ForEachLineInFile(path string, f func(string)) error {
	file, err := os.Open(path)

	if err != nil {
		return err
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		f(scanner.Text())
	}

	if err := scanner.Err(); err != nil {
		return err
	}
	return nil
}

func ForEachRuneInFile(path string, f func(int, string) bool) error {
	file, err := os.Open(path)

	if err != nil {
		return err
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	scanner.Split(bufio.ScanRunes)

	i := 0

	for scanner.Scan() {
		if f(i, scanner.Text()) {
			break
		}
		i += 1
	}
	return scanner.Err()
}
