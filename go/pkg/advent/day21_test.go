package advent

import (
	"reflect"
	"testing"
)

var sample21 = `root: pppw + sjmn
dbpl: 5
cczh: sllz + lgvd
zczc: 2
ptdq: humn - dvpt
dvpt: 3
lfqf: 4
humn: 5
ljgn: 2
sjmn: drzm * dbpl
sllz: 4
pppw: cczh / lfqf
lgvd: ljgn * ptdq
drzm: hmdt - zczc
hmdt: 32
`

func TestParseInputDay21(t *testing.T) {
	gotm, gote := parseInputDay21(sample21)
	wantm := map[string]int{
		"dbpl": 5,
		"zczc": 2,
		"dvpt": 3,
		"lfqf": 4,
		"humn": 5,
		"ljgn": 2,
		"sllz": 4,
		"hmdt": 32,
	}
	wante := map[string]MonkeyEquation{
		"root": {"pppw", "sjmn", "+"},
		"cczh": {"sllz", "lgvd", "+"},
		"ptdq": {"humn", "dvpt", "-"},
		"sjmn": {"drzm", "dbpl", "*"},
		"pppw": {"cczh", "lfqf", "/"},
		"lgvd": {"ljgn", "ptdq", "*"},
		"drzm": {"hmdt", "zczc", "-"},
	}

	if !reflect.DeepEqual(wantm, gotm) {
		t.Errorf("expected %v, got %v", wantm, gotm)
	}

	if !reflect.DeepEqual(wante, gote) {
		t.Errorf("expected %v, got %v", wante, gote)
	}
}

func TestSolveDay21Part1(t *testing.T) {
	want := 152
	got := solveDay21Part1(sample21)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}

func TestSolveDay21Part2(t *testing.T) {
	want := 301
	got := solveDay21Part2(sample21)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}
