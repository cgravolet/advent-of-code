package advent

import (
	"reflect"
	"testing"
)

var sample19 = `Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian.
Blueprint 2: Each ore robot costs 2 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 8 clay. Each geode robot costs 3 ore and 12 obsidian.
`

func TestParseInputPuzzle202219(t *testing.T) {
	want := []Blueprint{
		{
			ID:          1,
			OreBot:      ResourceCollection{4, 0, 0, 0},
			ClayBot:     ResourceCollection{2, 0, 0, 0},
			ObsidianBot: ResourceCollection{3, 14, 0, 0},
			GeodeBot:    ResourceCollection{2, 0, 7, 0},
		},
		{
			ID:          2,
			OreBot:      ResourceCollection{2, 0, 0, 0},
			ClayBot:     ResourceCollection{3, 0, 0, 0},
			ObsidianBot: ResourceCollection{3, 8, 0, 0},
			GeodeBot:    ResourceCollection{3, 0, 12, 0},
		},
	}
	got := parseInputPuzzle202219(sample19)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}

func TestSolvePuzzle202219Part1(t *testing.T) {
	want := 33
	got := solvePuzzle202219Part1(sample19)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}

func TestSolvePuzzle202219Part2(t *testing.T) {
	want := 56 * 62
	got := solvePuzzle202219Part2(sample19)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}
