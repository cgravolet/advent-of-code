package advent

import (
	"reflect"
	"testing"
)

var day13sample = `[1,1,3,1,1]
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

func TestSolveDay13Part1(t *testing.T) {
	want := 13
	got, err := solveDay13Part1(day13sample)

	if err != nil {
		t.Errorf("\n\tTestSolveDay13Part1 - Encountered error %v", err)
	}

	if !reflect.DeepEqual(want, got) {
		t.Errorf("\n\tTestSolveDay13Part1 - Expected %d, got %d", want, got)
	}
}
