package advent

import (
	"image"
	"reflect"
	"testing"
)

var sample24 = `#.######
#>>.<^<#
#.<..<<#
#>v.><>#
#<^v^^>#
######.#
`

func TestParseInputPuzzle202224(t *testing.T) {
	want := Mountain{
		start: image.Point{1, 0},
		end:   image.Point{6, 5},
		valley: [][]valleyEntity{
			{128, 0, 128, 128, 128, 128, 128, 128},
			{128, 16, 16, 0, 64, 8, 64, 128},
			{128, 0, 64, 0, 0, 64, 64, 128},
			{128, 16, 32, 0, 16, 64, 16, 128},
			{128, 64, 8, 32, 8, 8, 16, 128},
			{128, 128, 128, 128, 128, 128, 0, 128},
		},
	}

	got := parseInputPuzzle202224(sample24)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected: %v, got: %v", want, got)
	}
}

func TestSolvePuzzle202224Part1(t *testing.T) {
	want := 18
	got := solvePuzzle202224Part1(sample24)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected: %v, got: %v", want, got)
	}
}

func TestSolvePuzzle202224Part2(t *testing.T) {
	want := 54
	got := solvePuzzle202224Part2(sample24)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected: %v, got: %v", want, got)
	}
}
