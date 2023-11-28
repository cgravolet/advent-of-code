package advent

import (
	"image"
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
	want := ElfMap{
		grid: map[image.Point]bool{
			{0, 2}: true,
			{0, 4}: true,
			{0, 5}: true,
			{1, 3}: true,
			{1, 5}: true,
			{1, 6}: true,
			{2, 1}: true,
			{2, 4}: true,
			{3, 1}: true,
			{3, 4}: true,
			{3, 5}: true,
			{4, 0}: true,
			{4, 1}: true,
			{4, 2}: true,
			{4, 4}: true,
			{4, 6}: true,
			{5, 3}: true,
			{5, 5}: true,
			{6, 1}: true,
			{6, 2}: true,
			{6, 3}: true,
			{6, 5}: true,
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

func TestSolveDay23Part2(t *testing.T) {
	got := solveDay23Part2(sample23)
	want := 20

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected: %v, got: %v", want, got)
	}
}
