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

func TestParseInputPuzzle202221(t *testing.T) {
	got := parseInputPuzzle202221(sample21)
	want := YellerMonkeyGroup{
		"dbpl": {value: 5, didYell: true},
		"zczc": {value: 2, didYell: true},
		"dvpt": {value: 3, didYell: true},
		"lfqf": {value: 4, didYell: true},
		"humn": {value: 5, didYell: true},
		"ljgn": {value: 2, didYell: true},
		"sllz": {value: 4, didYell: true},
		"hmdt": {value: 32, didYell: true},
		"root": {left: "pppw", right: "sjmn", operator: "+"},
		"cczh": {left: "sllz", right: "lgvd", operator: "+"},
		"ptdq": {left: "humn", right: "dvpt", operator: "-"},
		"sjmn": {left: "drzm", right: "dbpl", operator: "*"},
		"pppw": {left: "cczh", right: "lfqf", operator: "/"},
		"lgvd": {left: "ljgn", right: "ptdq", operator: "*"},
		"drzm": {left: "hmdt", right: "zczc", operator: "-"},
	}

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}

func TestSolvePuzzle202221Part1(t *testing.T) {
	want := 152
	got := solvePuzzle202221Part1(sample21)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}

func TestSolvePuzzle202221Part2(t *testing.T) {
	want := 301
	got := solvePuzzle202221Part2(sample21)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}
