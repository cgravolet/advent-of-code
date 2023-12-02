package advent

import (
	"image"
	"reflect"
	"testing"
)

var sample22 = `        ...#
        .#..
        #...
        ....
...#.......#
........#...
..#....#....
..........#.
        ...#....
        .....#..
        .#......
        ......#.

10R5L5R10L4R5L5`

func TestParseInputPuzzle202222(t *testing.T) {
	wantmap := BoardMap{
		{0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 1, 1, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 1, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0},
		{1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 2, 0, 0, 0, 0},
		{1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 0, 0, 0, 0},
		{1, 1, 2, 1, 1, 1, 1, 2, 1, 1, 1, 1, 0, 0, 0, 0},
		{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 1, 1, 1, 1},
		{0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 1, 1},
		{0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 1, 1, 1, 1, 1, 1},
		{0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 2, 1},
	}
	wantinstructions := []PathInstruction{
		{PathRight, 10},
		{PathDown, 5},
		{PathRight, 5},
		{PathDown, 10},
		{PathRight, 4},
		{PathDown, 5},
		{PathRight, 5},
	}
	wantstart := image.Point{8, 0}
	gotmap, gotstart, gotinstructions := parseInputPuzzle202222(sample22)

	if !reflect.DeepEqual(wantmap, gotmap) {
		t.Errorf("expected %v, got %v", wantmap, gotmap)
	}

	if !reflect.DeepEqual(wantstart, gotstart) {
		t.Errorf("expected %v, got %v", wantstart, gotstart)
	}

	if !reflect.DeepEqual(wantinstructions, gotinstructions) {
		t.Errorf("expected %v, got %v", wantinstructions, gotinstructions)
	}
}

func TestSolvePuzzle202222Part1(t *testing.T) {
	want := 6032
	got := solvePuzzle202222Part1(sample22)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}

func TestSolvePuzzle202222Part2(t *testing.T) {
	want := 5031
	got := solvePuzzle202222Part2(sample22)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}
