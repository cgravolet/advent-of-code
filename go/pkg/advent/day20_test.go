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

func TestParseInputDay20(t *testing.T) {
	want := []int{1, 2, -3, 3, -2, 0, 4}
	got := parseInputDay20(sample20)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}

func TestSolveDay20Part1(t *testing.T) {
	want := 3
	got := solveDay20Part1(parseInputDay20(sample20))

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}
