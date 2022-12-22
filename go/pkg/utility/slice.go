package utility

import "fmt"

func InsertElement(s []int, e int, i int) ([]int, error) {
	if i >= len(s) || i < 0 {
		return s, fmt.Errorf("index %d out of range", i)
	}
	end := []int{e}
	end = append(end, s[i:]...)
	return append(s[:i], end...), nil
}

func MoveElement(s []int, from int, to int) ([]int, error) {
	seq, el, err := RemoveElement(s, from)

	if err != nil {
		return s, err
	}

	if to == len(seq) {
		return append(seq, el), nil
	}
	return InsertElement(seq, el, to)
}

func RemoveElement(s []int, i int) ([]int, int, error) {
	if i >= len(s) || i < 0 {
		return s, -1, fmt.Errorf("index %d out of range", i)
	}
	el := s[i]
	return append(s[:i], s[i+1:]...), el, nil
}

func SliceIndex(limit int, predicate func(i int) bool) int {
	for i := 0; i < limit; i++ {
		if predicate(i) {
			return i
		}
	}
	return -1
}
