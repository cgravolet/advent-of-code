package utility

import (
	"bufio"
	"io"
)

func Map[T, U any](data []T, f func(T) U) []U {
	res := []U{}
	for _, d := range data {
		res = append(res, f(d))
	}
	return res
}

func MapLinesInReader[T any](r io.Reader, f func(string) T) ([]T, error) {
	var res []T
	scanner := bufio.NewScanner(r)

	for scanner.Scan() {
		res = append(res, f(scanner.Text()))
	}

	if err := scanner.Err(); err != nil {
		return res, err
	}
	return res, nil
}
