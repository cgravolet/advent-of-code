package advent

import (
	"reflect"
	"testing"
)

var sample23 = `....#..
..###.#
#...#.#
.#...##
#.###..
##.#.##
.#..#..
`

func TestParseInputDay23(t *testing.T) {
	got := parseInputDay23(sample23)
	want := map[int]map[int]bool{
		0: {
			2: true,
			4: true,
			5: true,
		},
		1: {
			3: true,
			5: true,
			6: true,
		},
		2: {
			1: true,
			4: true,
		},
		3: {
			1: true,
			4: true,
			5: true,
		},
		4: {
			0: true,
			1: true,
			2: true,
			4: true,
			6: true,
		},
		5: {
			3: true,
			5: true,
		},
		6: {
			1: true,
			2: true,
			3: true,
			5: true,
		},
	}

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected:\n%v\ngot:\n%v\n", want, got)
	}
}

func TestSolveDay23Part1(t *testing.T) {
	got := solveDay23Part1(sample23)
	want := 110

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected: %v, got: %v", want, got)
	}
}
