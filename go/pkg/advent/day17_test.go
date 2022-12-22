package advent

import (
	"container/ring"
	"reflect"
	"testing"
)

var sample17 = `>>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>`

func TestParseInputDay17(t *testing.T) {
	want := ring.New(40)
	got := parseInputDay17(sample17)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}
