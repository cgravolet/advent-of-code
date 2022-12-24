package advent

import (
	"reflect"
	"testing"
)

var sample17 = `>>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>`

func TestParseInputDay17(t *testing.T) {
	input := parseInputDay17(sample17)
	got := ""

	for i := 0; i < input.Len(); i++ {
		got += string(input.Value.(JetDirection))
		input = input.Next()
	}

	if !reflect.DeepEqual(got, sample17) {
		t.Errorf("expected %v, got %v", sample17, got)
	}
}

func TestSolveDay17Part1(t *testing.T) {
	want := 3068
	got := solveDay17Part1(sample17)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}

func TestSolveDay17Part2(t *testing.T) {
	want := 1514285714288
	got := solveDay17Part2(sample17)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}
