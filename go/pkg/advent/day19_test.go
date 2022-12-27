package advent

import (
	"reflect"
	"testing"
)

var sample19 = `Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian.
Blueprint 2: Each ore robot costs 2 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 8 clay. Each geode robot costs 3 ore and 12 obsidian.
`

func TestParseInputDay19(t *testing.T) {
	want := []Blueprint{
		{
			ID:          1,
			OreBot:      BotCost{4, 0, 0},
			ClayBot:     BotCost{2, 0, 0},
			ObsidianBot: BotCost{3, 14, 0},
			GeodeBot:    BotCost{2, 0, 7},
		},
		{
			ID:          2,
			OreBot:      BotCost{2, 0, 0},
			ClayBot:     BotCost{3, 0, 0},
			ObsidianBot: BotCost{3, 8, 0},
			GeodeBot:    BotCost{3, 0, 12},
		},
	}
	got := parseInputDay19(sample19)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}

func TestSolveDay19Part1(t *testing.T) {
	want := 33
	got := solveDay19Part1(sample19)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}
