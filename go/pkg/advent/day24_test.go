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

func TestParseInputDay24(t *testing.T) {
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

	got := parseInputDay24(sample24)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected: %v, got: %v", want, got)
	}
}

func TestSolveDay24Part1(t *testing.T) {
	want := 18
	got := solveDay24Part1(sample24)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected: %v, got: %v", want, got)
	}
}

func TestSolveDay24Part2(t *testing.T) {
	want := -1
	got := solveDay24Part2(sample24)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected: %v, got: %v", want, got)
	}
}
