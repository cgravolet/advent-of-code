package advent

import (
	"reflect"
	"testing"
)

var day16sample = `Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
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
		"AA": {0, []string{"DD", "II", "BB"}},
		"BB": {13, []string{"CC", "AA"}},
		"CC": {2, []string{"DD", "BB"}},
		"DD": {20, []string{"CC", "AA", "EE"}},
		"EE": {3, []string{"FF", "DD"}},
		"FF": {0, []string{"EE", "GG"}},
		"GG": {0, []string{"FF", "HH"}},
		"HH": {22, []string{"GG"}},
		"II": {0, []string{"AA", "JJ"}},
		"JJ": {21, []string{"II"}},
	}
	got := parseInputDay16(day16sample)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}
