package advent

import (
	"reflect"
	"testing"
)

var sample17 = `>>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>`

func TestParseInputDay17(t *testing.T) {
	want := 40
	got := parseInputDay17(sample17)

	if !reflect.DeepEqual(want, got.Len()) {
		t.Errorf("expected %v, got %v", want, got)
	}

	if got.Value != JetLeft {
		t.Errorf("expected %v, got %v", JetLeft, got.Value)
	}
}

func TestSolveDay17Part1(t *testing.T) {
	want := 3068
	got := solveDay17Part1(sample17)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}
