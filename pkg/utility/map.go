package utility

import (
	"bufio"
	"os"
)

func Map[T, U any](data []T, f func(T) U) []U {
	res := []U{}
	for _, d := range data {
		res = append(res, f(d))
	}
	return res
}

func MapLinesInFile[T any](path string, f func(string) T) ([]T, error) {
	var res []T
	file, err := os.Open(path)

	if err != nil {
		return res, err
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		res = append(res, f(scanner.Text()))
	}

	if err := scanner.Err(); err != nil {
		return res, err
	}
	return res, nil
}
