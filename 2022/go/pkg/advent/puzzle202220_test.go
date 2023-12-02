package advent

import (
	"reflect"
	"testing"
)

var sample20 = `1
2
-3
3
-2
0
4
`

func TestParseInputPuzzle202220(t *testing.T) {
	want := []int{1, 2, -3, 3, -2, 0, 4}
	got := parseInputPuzzle202220(sample20)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}

func TestSolvePuzzle202220Part1(t *testing.T) {
	want := 3
	got := solvePuzzle202220Part1(sample20)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}

func TestSolvePuzzle202220Part2(t *testing.T) {
	want := 1623178306
	got := solvePuzzle202220Part2(sample20)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}
