package advent

import (
	"reflect"
	"testing"
)

var sample16 = `Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
Valve BB has flow rate=13; tunnels lead to valves CC, AA
Valve CC has flow rate=2; tunnels lead to valves DD, BB
Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE
Valve EE has flow rate=3; tunnels lead to valves FF, DD
Valve FF has flow rate=0; tunnels lead to valves EE, GG
Valve GG has flow rate=0; tunnels lead to valves FF, HH
Valve HH has flow rate=22; tunnel leads to valve GG
Valve II has flow rate=0; tunnels lead to valves AA, JJ
Valve JJ has flow rate=21; tunnel leads to valve II
`

func TestParseInputDay16(t *testing.T) {
	want := map[string]Valve{
		"AA": {"AA", 0, []string{"DD", "II", "BB"}},
		"BB": {"BB", 13, []string{"CC", "AA"}},
		"CC": {"CC", 2, []string{"DD", "BB"}},
		"DD": {"DD", 20, []string{"CC", "AA", "EE"}},
		"EE": {"EE", 3, []string{"FF", "DD"}},
		"FF": {"FF", 0, []string{"EE", "GG"}},
		"GG": {"GG", 0, []string{"FF", "HH"}},
		"HH": {"HH", 22, []string{"GG"}},
		"II": {"II", 0, []string{"AA", "JJ"}},
		"JJ": {"JJ", 21, []string{"II"}},
	}
	got, first := parseInputDay16(sample16)

	if first != "AA" {
		t.Errorf("expected 'AA', got '%s'", first)
	}

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}

func TestSolveDay16Part1(t *testing.T) {
	input, first := parseInputDay16(sample16)
	want := 1651
	got := solveDay16Part1(input, first, 30)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}
