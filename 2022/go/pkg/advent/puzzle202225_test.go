package advent

import (
	"reflect"
	"testing"
)

var sample25 = `1=-0-2
12111
2=0=
21
2=01
111
20012
112
1=-1=
1-12
12
1=
122
`

func TestSnafuIntValue(t *testing.T) {
	type test struct {
		want  int
		input SnafuNumber
	}
	tests := []test{
		{1, "1"},
		{2, "2"},
		{3, "1="},
		{4, "1-"},
		{5, "10"},
		{6, "11"},
		{7, "12"},
		{8, "2="},
		{9, "2-"},
		{10, "20"},
		{15, "1=0"},
		{20, "1-0"},
		{2022, "1=11-2"},
		{12345, "1-0---0"},
		{314159265, "1121-1110-1=0"},
		{1747, "1=-0-2"},
		{906, "12111"},
		{198, "2=0="},
		{11, "21"},
		{201, "2=01"},
		{31, "111"},
		{1257, "20012"},
		{32, "112"},
		{353, "1=-1="},
		{107, "1-12"},
		{7, "12"},
		{3, "1="},
		{37, "122"},
	}

	for _, test := range tests {
		got := test.input.IntValue()

		if !reflect.DeepEqual(test.want, got) {
			t.Errorf("expected: %v, got: %v", test.want, got)
		}
	}
}

func TestNewSnafuNumber(t *testing.T) {
	type test struct {
		input int
		want  SnafuNumber
	}
	tests := []test{
		{1, "1"},
		{2, "2"},
		{3, "1="},
		{4, "1-"},
		{5, "10"},
		{6, "11"},
		{7, "12"},
		{8, "2="},
		{9, "2-"},
		{10, "20"},
		{15, "1=0"},
		{20, "1-0"},
		{2022, "1=11-2"},
		{12345, "1-0---0"},
		{314159265, "1121-1110-1=0"},
		{1747, "1=-0-2"},
		{906, "12111"},
		{198, "2=0="},
		{11, "21"},
		{201, "2=01"},
		{31, "111"},
		{1257, "20012"},
		{32, "112"},
		{353, "1=-1="},
		{107, "1-12"},
		{7, "12"},
		{3, "1="},
		{37, "122"},
	}

	for _, test := range tests {
		got := NewSnafuNumber(test.input)

		if !reflect.DeepEqual(test.want, got) {
			t.Errorf("expected: %v, got: %v", test.want, got)
		}
	}
}

func TestSolvePuzzle202225Part1(t *testing.T) {
	wantnum := 4890
	wantstr := SnafuNumber("2=-1=0")
	gotnum, gotstr := solvePuzzle202225Part1(sample25)

	if !reflect.DeepEqual(wantnum, gotnum) {
		t.Errorf("expected: %v, got: %v", wantnum, gotnum)
	}

	if !reflect.DeepEqual(wantstr, gotstr) {
		t.Errorf("expected: %v, got: %v", wantstr, gotstr)
	}
}
