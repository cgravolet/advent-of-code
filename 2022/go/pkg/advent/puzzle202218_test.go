package advent

import (
	"reflect"
	"testing"
)

var sample18 = `2,2,2
1,2,2
3,2,2
2,1,2
2,3,2
2,2,1
2,2,3
2,2,4
2,2,6
1,2,5
3,2,5
2,1,5
2,3,5
`

func TestParseInputPuzzle202218(t *testing.T) {
	want := []Point3D{
		{3, 3, 3}, {2, 3, 3}, {4, 3, 3}, {3, 2, 3}, {3, 4, 3}, {3, 3, 2}, {3, 3, 4},
		{3, 3, 5}, {3, 3, 7}, {2, 3, 6}, {4, 3, 6}, {3, 2, 6}, {3, 4, 6},
	}
	wantb := Boundary{4, 4, 7, 2, 2, 2}
	got, gotb := parseInputPuzzle202218(sample18)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}

	if !reflect.DeepEqual(wantb, gotb) {
		t.Errorf("expected %v, got %v", wantb, gotb)
	}
}

func TestSolvePuzzle202218Part1(t *testing.T) {
	want := 64
	got := solvePuzzle202218Part1(sample18)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}

func TestSolvePuzzle202218Part2(t *testing.T) {
	want := 58
	got := solvePuzzle202218Part2(sample18)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}
