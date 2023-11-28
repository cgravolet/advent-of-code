package utility

import (
	"bufio"
	"io"
)

func ForEachLineInReader(r io.Reader, f func(string)) error {
	scanner := bufio.NewScanner(r)

	for scanner.Scan() {
		f(scanner.Text())
	}

	if err := scanner.Err(); err != nil {
		return err
	}
	return nil
}

func ForEachRuneInReader(r io.Reader, f func(int, string) bool) error {
	scanner := bufio.NewScanner(r)
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
