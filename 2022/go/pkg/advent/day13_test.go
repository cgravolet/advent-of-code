package advent

import (
	"reflect"
	"testing"
)

var sample13 = `[1,1,3,1,1]
[1,1,5,1,1]

[[1],[2,3,4]]
[[1],4]

[9]
[[8,7,6]]

[[4,4],4,4]
[[4,4],4,4,4]

[7,7,7,7]
[7,7,7]

[]
[3]

[[[]]]
[[]]

[1,[2,[3,[4,[5,6,7]]]],8,9]
[1,[2,[3,[4,[5,6,0]]]],8,9]
`

func TestCompareGroup(t *testing.T) {
	type test struct {
		lhs  []any
		rhs  []any
		want int
	}

	tests := []test{
		{[]any{1.0, 1.0, 3.0, 1.0, 1.0}, []any{1.0, 1.0, 5.0, 1.0, 1.0}, 1},
		{[]any{[]any{1.0}, []any{2.0, 3.0, 4.0}}, []any{[]any{1.0}, 4.0}, 1},
		{[]any{9.0}, []any{[]any{8.0, 7.0, 6.0}}, -1},
		{[]any{[]any{4.0, 4.0}, 4.0, 4.0}, []any{[]any{4.0, 4.0}, 4.0, 4.0, 4.0}, 1},
		{[]any{7.0, 7.0, 7.0, 7.0}, []any{7.0, 7.0, 7.0}, -1},
		{[]any{}, []any{3.0}, 1},
		{[]any{[]any{[]any{}}}, []any{[]any{}}, -1},
		{[]any{1.0, []any{2.0, []any{3.0, []any{4.0, []any{5.0, 6.0, 7.0}}}}, 8.0, 9.0}, []any{1.0, []any{2.0, []any{3.0, []any{4.0, []any{5.0, 6.0, 0.0}}}}, 8.0, 9.0}, -1},
		{[]any{[]any{3.0, 4.0}, []any{2.0, 4.0}}, []any{[]any{3.0, 4.0}, []any{2.0, 5.0}}, 1},
	}

	for _, test := range tests {
		got := compareGroup(test.lhs, test.rhs)
		if !reflect.DeepEqual(got, test.want) {
			t.Errorf("\n\tTestCompareGroup - Expected %d, got %d", test.want, got)
		}
	}
}

func TestDay13Part1(t *testing.T) {
	want := 13
	got, err := day13part1(sample13)

	if err != nil {
		t.Errorf("\n\tTestSolveDay13Part1 - Encountered error %v", err)
	}

	if !reflect.DeepEqual(want, got) {
		t.Errorf("\n\tTestSolveDay13Part1 - Expected %d, got %d", want, got)
	}
}

func TestDay13Part2(t *testing.T) {
	want := 140
	got, err := day13part2(sample13)

	if err != nil {
		t.Errorf("\n\tTestSolveDay13Part1 - Encountered error %v", err)
	}

	if !reflect.DeepEqual(want, got) {
		t.Errorf("\n\tTestSolveDay13Part1 - Expected %d, got %d", want, got)
	}
}
