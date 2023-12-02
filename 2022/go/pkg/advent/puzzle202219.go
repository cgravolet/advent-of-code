package advent

import (
	"fmt"
	"regexp"
	"strconv"

	"github.com/cgravolet/adventofcode2022/pkg/utility"
)

func (a *AdventOfCode2022) Puzzle202219(input string) {
	part1 := solvePuzzle202219Part1(input)
	part2 := solvePuzzle202219Part2(input)
	fmt.Printf("Part 1: %d\n", part1)
	fmt.Printf("Part 2: %d\n", part2)
}

// Data structures

type Blueprint struct {
	ID          int
	OreBot      ResourceCollection
	ClayBot     ResourceCollection
	ObsidianBot ResourceCollection
	GeodeBot    ResourceCollection
}

type ResourceCollection struct {
	Ore      int
	Clay     int
	Obsidian int
	Geode    int
}

func (bp Blueprint) MaxGeodes(time int) int {
	type state struct {
		resources ResourceCollection
		bots      ResourceCollection
		time      int
	}

	stateDescription := func(s state) string {
		return fmt.Sprintf("%d%d%d%d-%d%d%d%d-%d",
			s.resources.Ore, s.resources.Clay, s.resources.Obsidian, s.resources.Geode,
			s.bots.Ore, s.bots.Clay, s.bots.Obsidian, s.bots.Geode,
			s.time)
	}

	var maxGeodes int
	queue := []state{{ResourceCollection{}, ResourceCollection{1, 0, 0, 0}, 1}}
	cache := make(map[string]bool)
	craft := make(map[int]int)

	for len(queue) > 0 {
		s := queue[0]
		queue = queue[1:]
		d := stateDescription(s)

		_, seen := cache[d]
		if seen {
			continue
		}
		cache[d] = true
		r := s.resources
		b := s.bots
		t := s.time

		if t > time {
			maxGeodes = utility.MaxInt(maxGeodes, s.resources.Geode)
			continue
		}

		if r.Ore >= bp.GeodeBot.Ore && r.Obsidian >= bp.GeodeBot.Obsidian {
			queue = append(queue, state{
				ResourceCollection{
					Ore:      r.Ore - bp.GeodeBot.Ore + b.Ore,
					Clay:     r.Clay + b.Clay,
					Obsidian: r.Obsidian - bp.GeodeBot.Obsidian + b.Obsidian,
					Geode:    r.Geode + b.Geode,
				},
				ResourceCollection{b.Ore, b.Clay, b.Obsidian, b.Geode + 1},
				t + 1,
			})
			craft[t] = b.Geode
			continue
		} else if r.Ore >= bp.ObsidianBot.Ore && r.Clay >= bp.ObsidianBot.Clay {
			queue = append(queue, state{
				ResourceCollection{
					Ore:      r.Ore - bp.ObsidianBot.Ore + b.Ore,
					Clay:     r.Clay - bp.ObsidianBot.Clay + b.Clay,
					Obsidian: r.Obsidian + b.Obsidian,
					Geode:    r.Geode + b.Geode,
				},
				ResourceCollection{b.Ore, b.Clay, b.Obsidian + 1, b.Geode},
				t + 1,
			})
			continue
		}

		geodeBots, crafted := craft[t]
		if crafted && geodeBots == b.Geode {
			continue
		}

		if r.Ore >= bp.ClayBot.Ore {
			queue = append(queue, state{
				ResourceCollection{
					Ore:      r.Ore - bp.ClayBot.Ore + b.Ore,
					Clay:     r.Clay + b.Clay,
					Obsidian: r.Obsidian + b.Obsidian,
					Geode:    r.Geode + b.Geode,
				},
				ResourceCollection{b.Ore, b.Clay + 1, b.Obsidian, b.Geode},
				t + 1,
			})
		}

		if r.Ore >= bp.OreBot.Ore {
			queue = append(queue, state{
				ResourceCollection{
					Ore:      r.Ore - bp.OreBot.Ore + b.Ore,
					Clay:     r.Clay + b.Clay,
					Obsidian: r.Obsidian + b.Obsidian,
					Geode:    r.Geode + b.Geode,
				},
				ResourceCollection{b.Ore + 1, b.Clay, b.Obsidian, b.Geode},
				t + 1,
			})
		}

		queue = append(queue, state{
			ResourceCollection{
				Ore:      r.Ore + b.Ore,
				Clay:     r.Clay + b.Clay,
				Obsidian: r.Obsidian + b.Obsidian,
				Geode:    r.Geode + b.Geode,
			},
			ResourceCollection{b.Ore, b.Clay, b.Obsidian, b.Geode},
			t + 1,
		})
	}
	return maxGeodes
}

func (bp Blueprint) QualityLevel(time int) int {
	return bp.MaxGeodes(time) * bp.ID
}

// Parse

func parseInputPuzzle202219(input string) []Blueprint {
	var blueprints []Blueprint
	regex := regexp.MustCompile(`Blueprint (\d+):\s+Each ore robot costs (\d+) ore\.\s+Each clay robot costs (\d+) ore\.\s+Each obsidian robot costs (\d+) ore and (\d+) clay\.\s+Each geode robot costs (\d+) ore and (\d+) obsidian.`)

	for _, match := range regex.FindAllStringSubmatch(input, -1) {
		if len(match) != 8 {
			continue
		}
		g1, _ := strconv.Atoi(match[1])
		g2, _ := strconv.Atoi(match[2])
		g3, _ := strconv.Atoi(match[3])
		g4, _ := strconv.Atoi(match[4])
		g5, _ := strconv.Atoi(match[5])
		g6, _ := strconv.Atoi(match[6])
		g7, _ := strconv.Atoi(match[7])
		bp := Blueprint{
			ID:          g1,
			OreBot:      ResourceCollection{g2, 0, 0, 0},
			ClayBot:     ResourceCollection{g3, 0, 0, 0},
			ObsidianBot: ResourceCollection{g4, g5, 0, 0},
			GeodeBot:    ResourceCollection{g6, 0, g7, 0},
		}
		blueprints = append(blueprints, bp)
	}
	return blueprints
}

// Solve

func solvePuzzle202219Part1(input string) int {
	var sum int
	for _, bp := range parseInputPuzzle202219(input) {
		sum += bp.QualityLevel(24)
	}
	return sum
}

func solvePuzzle202219Part2(input string) int {
	sum := 1
	for i, bp := range parseInputPuzzle202219(input) {
		if i >= 3 {
			break
		}
		sum *= bp.MaxGeodes(32)
	}
	return sum
}
