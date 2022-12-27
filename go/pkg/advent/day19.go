package advent

import (
	"fmt"
	"regexp"
	"strconv"

	"github.com/cgravolet/adventofcode2022/pkg/utility"
)

func (a *AdventOfCode2022) Day19(input string) {
	part1 := solveDay19Part1(input)
	fmt.Printf("Part 1: %d\n", part1)
}

// Data structures

type Blueprint struct {
	ID          int
	OreBot      BotCost
	ClayBot     BotCost
	ObsidianBot BotCost
	GeodeBot    BotCost
}

type BotCost struct {
	Ore      int
	Clay     int
	Obsidian int
}

func (bp Blueprint) MaxCost() BotCost {
	return BotCost{
		utility.MaxInt(bp.OreBot.Ore, bp.ClayBot.Ore, bp.ObsidianBot.Ore, bp.GeodeBot.Ore),
		utility.MaxInt(bp.OreBot.Clay, bp.ClayBot.Clay, bp.ObsidianBot.Clay, bp.GeodeBot.Clay),
		utility.MaxInt(bp.OreBot.Obsidian, bp.ClayBot.Obsidian, bp.ObsidianBot.Obsidian, bp.GeodeBot.Obsidian),
	}
}

func (bp Blueprint) QualityLevel(time int) int {
	resources := struct{ ore, clay, obsidian, geode int }{}
	bots := struct{ ore, clay, obsidian, geode int }{1, 0, 0, 0}

	for i := 0; i < time; i++ {
		order := struct{ ore, clay, obsidian, geode bool }{}
		fmt.Printf("\n== Minute %d ==\n", i+1)

		// Spend ore to begin crafting a robot, if possible
		if resources.ore >= bp.GeodeBot.Ore && resources.obsidian >= bp.GeodeBot.Obsidian {
			resources.ore -= bp.GeodeBot.Ore
			resources.obsidian -= bp.GeodeBot.Obsidian
			order.geode = true
			fmt.Printf("Spend %d ore and %d obsidian to start building a geode-cracking robot.\n", bp.GeodeBot.Ore, bp.GeodeBot.Obsidian)
		} else if resources.ore >= bp.ObsidianBot.Ore && resources.clay >= bp.ObsidianBot.Clay {
			resources.ore -= bp.ObsidianBot.Ore
			resources.clay -= bp.ObsidianBot.Clay
			order.obsidian = true
			fmt.Printf("Spend %d ore and %d clay to start building an obsidian-collecting robot.\n", bp.ObsidianBot.Ore, bp.ObsidianBot.Clay)
		} else if resources.ore >= bp.ClayBot.Ore {
			resources.ore -= bp.ClayBot.Ore
			order.clay = true
			fmt.Printf("Spend %d ore to start building a clay-collecting robot.\n", bp.ClayBot.Ore)
		} else if resources.ore >= bp.OreBot.Ore {
			resources.ore -= bp.OreBot.Ore
			order.ore = true
			fmt.Printf("Spend %d ore to start building an ore-collecting robot.\n", bp.ClayBot.Ore)
		}

		// Mine resources
		resources.ore += bots.ore
		fmt.Printf("%d ore-collecting robot collects %d ore; you now have %d ore.\n", bots.ore, bots.ore, resources.ore)

		if bots.clay > 0 {
			resources.clay += bots.clay
			fmt.Printf("%d clay-collecting robots collects %d clay; you now have %d clay.\n", bots.clay, bots.clay, resources.clay)
		}
		if bots.obsidian > 0 {
			resources.obsidian += bots.obsidian
			fmt.Printf("%d obsidian-collecting robots collects %d obsidian; you now have %d obsidian.\n", bots.obsidian, bots.obsidian, resources.obsidian)
		}
		if bots.geode > 0 {
			resources.geode += bots.geode
			fmt.Printf("%d geode-cracking robots cracks %d geode; you now have %d open geodes.\n", bots.geode, bots.geode, resources.geode)
		}

		// Complete robot construction
		if order.geode {
			bots.geode++
			fmt.Printf("The new geode-cracking robot is ready; you now have %d of them.\n", bots.geode)
		} else if order.obsidian {
			bots.obsidian++
			fmt.Printf("The new obsidian-collecting robot is ready; you now have %d of them.\n", bots.obsidian)
		} else if order.clay {
			bots.clay++
			fmt.Printf("The new clay-collecting robot is ready; you now have %d of them.\n", bots.clay)
		} else if order.ore {
			bots.ore++
			fmt.Printf("The new ore-collecting robot is ready; you now have %d of them.\n", bots.ore)
		}
	}
	return resources.geode * bp.ID
}

// Parse

func parseInputDay19(input string) []Blueprint {
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
			OreBot:      BotCost{g2, 0, 0},
			ClayBot:     BotCost{g3, 0, 0},
			ObsidianBot: BotCost{g4, g5, 0},
			GeodeBot:    BotCost{g6, 0, g7},
		}
		blueprints = append(blueprints, bp)
	}
	return blueprints
}

// Solve

func solveDay19Part1(input string) int {
	var sum int
	for _, bp := range parseInputDay19(input) {
		sum += bp.QualityLevel(24)
	}
	return sum
}
