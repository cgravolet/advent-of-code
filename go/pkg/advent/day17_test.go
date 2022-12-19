package advent

import (
	"container/ring"
	"reflect"
	"testing"
)

var day17sample = `>>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>`

func TestParseInputDay17(t *testing.T) {
	want := ring.New(40)
	got := parseInputDay17(day17sample)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}
