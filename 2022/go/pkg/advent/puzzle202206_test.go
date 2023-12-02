package advent

import (
	"reflect"
	"strings"
	"testing"
)

func TestPuzzle202206(t *testing.T) {
	type test struct {
		input string
		size  int
		want  int
	}

	tests := []test{
		{"bvwbjplbgvbhsrlpgdmjqwftvncz", 4, 5},
		{"nppdvjthqldpwncqszvftbrmjlhg", 4, 6},
		{"nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 4, 10},
		{"zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 4, 11},
		{"mjqjpqmgbljsphdztnvjfqwrcgsmlb", 14, 19},
		{"bvwbjplbgvbhsrlpgdmjqwftvncz", 14, 23},
		{"nppdvjthqldpwncqszvftbrmjlhg", 14, 23},
		{"nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 14, 29},
		{"zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 14, 26},
	}

	for _, tc := range tests {
		got, err := findMarkerInFile(strings.NewReader(tc.input), tc.size)
		if err != nil {
			t.Errorf("encountered error: %v", err)
		} else if !reflect.DeepEqual(tc.want, got) {
			t.Errorf("expected: %v, got: %v", tc.want, got)
		}
	}
}
