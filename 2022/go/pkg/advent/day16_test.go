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
		"AA": {"AA", 0, []string{"DD", "II", "BB"}, 0},
		"BB": {"BB", 13, []string{"CC", "AA"}, 0},
		"CC": {"CC", 2, []string{"DD", "BB"}, 1},
		"DD": {"DD", 20, []string{"CC", "AA", "EE"}, 2},
		"EE": {"EE", 3, []string{"FF", "DD"}, 3},
		"FF": {"FF", 0, []string{"EE", "GG"}, 4},
		"GG": {"GG", 0, []string{"FF", "HH"}, 4},
		"HH": {"HH", 22, []string{"GG"}, 4},
		"II": {"II", 0, []string{"AA", "JJ"}, 5},
		"JJ": {"JJ", 21, []string{"II"}, 5},
	}
	got, _ := parseInputDay16(sample16)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}

func TestSolveDay16Part1(t *testing.T) {
	want := 1651
	got := solveDay16Part1(sample16)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}

func TestSolveDay16Part2(t *testing.T) {
	want := 1707
	got := solveDay16Part2(sample16)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}
