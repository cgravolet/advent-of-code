package advent

import (
	"reflect"
	"testing"
)

var sample19 = `Blueprint 1:
Each ore robot costs 4 ore.
Each clay robot costs 2 ore.
Each obsidian robot costs 3 ore and 14 clay.
Each geode robot costs 2 ore and 7 obsidian.

Blueprint 2:
Each ore robot costs 2 ore.
Each clay robot costs 3 ore.
Each obsidian robot costs 3 ore and 8 clay.
Each geode robot costs 3 ore and 12 obsidian.
`

func TestParseInputDay19(t *testing.T) {
	want := ""
	got := parseInputDay19(sample19)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}