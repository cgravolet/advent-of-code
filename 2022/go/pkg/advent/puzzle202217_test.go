package advent

import (
	"reflect"
	"testing"
)

var sample17 = `>>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>`

func TestSolvePuzzle202217Part1(t *testing.T) {
	want := 3068
	got := solvePuzzle202217Part1(sample17)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}

func TestSolvePuzzle202217Part2(t *testing.T) {
	want := 1514285714288
	got := solvePuzzle202217Part2(sample17)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}
