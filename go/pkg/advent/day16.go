package advent

import (
	"fmt"
	"regexp"
	"strconv"
	"strings"

	"github.com/cgravolet/adventofcode2022/pkg/utility"
)

func (a *AdventOfCode2022) Day16(input string) {
	part1, part2 := solveDay16Part1(input), solveDay16Part2(input)
	fmt.Printf("Part 1: %d\n", part1)
	fmt.Printf("Part 2: %d\n", part2)
}

// Data structures

type Valve struct {
	Name        string
	FlowRate    int
	Connections []string
	Index       int
}

type ValveMap map[string]map[string]int

type Day16Cache map[int]map[string]map[int]int

func (c *Day16Cache) addItem(time int, valve string, bitmask int, pressure int) {
	_, ok := (*c)[time]

	if !ok {
		(*c)[time] = make(map[string]map[int]int)
	}
	_, ok = (*c)[time][valve]

	if !ok {
		(*c)[time][valve] = make(map[int]int)
	}
	(*c)[time][valve][bitmask] = pressure
}

func (c *Day16Cache) getItem(time int, valve string, bitmask int) (val int, ok bool) {
	val, ok = (*c)[time][valve][bitmask]
	return
}

// Parse

func parseInputDay16(input string) (map[string]Valve, int) {
	var index int
	valveMap := make(map[string]Valve)

	utility.ForEachLineInReader(strings.NewReader(input), func(s string) {
		re := regexp.MustCompile(`Valve (\w{2}) has flow rate=(\d+); tunnels? leads? to valves? ([A-Z, ]+)`)
		matches := re.FindStringSubmatch(s)
		name := matches[1]
		rate, _ := strconv.Atoi(matches[2])
		valve := Valve{name, rate, []string{}, index}

		if rate > 0 {
			index++
		}

		for _, c := range strings.Split(matches[3], ",") {
			valve.Connections = append(valve.Connections, strings.TrimSpace(c))
		}
		valveMap[name] = valve
	})
	return valveMap, index
}

// Solve

func solveDay16Part1(input string) int {
	v, _ := parseInputDay16(input)
	vm := makeValveMap(v)
	cache := make(Day16Cache)
	return traverse(vm, v, cache, 30, "AA", 0)
}

func solveDay16Part2(input string) int {
	v, maplen := parseInputDay16(input)
	vm := makeValveMap(v)
	cache := make(Day16Cache)
	pressure, bitmask := 0, (1<<maplen)-1

	for i := 0; i < (bitmask+1)/2; i++ {
		val := traverse(vm, v, cache, 26, "AA", i) + traverse(vm, v, cache, 26, "AA", bitmask^i)
		pressure = utility.MaxInt(pressure, val)
	}
	return pressure
}

// Helper methods

func makeValveMap(valves map[string]Valve) ValveMap {
	vm := make(ValveMap)

	type destination struct {
		distance int
		name     string
	}

	for _, valve := range valves {
		// Exclude valves with a flow rate of 0, those are just stops on the way to more worthwhile destinations.
		// The one exception is our starting point, "AA".
		if valve.Name != "AA" && valve.FlowRate <= 0 {
			continue
		}
		vm[valve.Name] = make(map[string]int)
		queue := []destination{{0, valve.Name}}
		visited := []string{valve.Name}

		for len(queue) > 0 {
			dest := queue[0]
			queue = queue[1:]

			for _, connection := range valves[dest.name].Connections {
				if utility.ContainsString(visited, connection) {
					continue
				}
				visited = append(visited, connection)

				if valves[connection].FlowRate > 0 {
					vm[valve.Name][connection] = dest.distance + 1
				}
				queue = append(queue, destination{dest.distance + 1, connection})
			}
		}

		// If the current valve connects back to our starting point, remove that connection so we don't loop back to the
		// start of the map.
		if valve.Name != "AA" {
			delete(vm[valve.Name], "AA")
		}
	}
	return vm
}

func traverse(vm ValveMap, valves map[string]Valve, cache Day16Cache, time int, valve string, bitmask int) int {
	val, ok := cache.getItem(time, valve, bitmask)
	if ok {
		return val
	}
	var pressure int
	for n, dist := range vm[valve] {
		bit := 1 << valves[n].Index
		if bitmask&bit > 0 {
			continue
		}
		rt := time - dist - 1

		if rt <= 0 {
			continue
		}
		pressure = utility.MaxInt(pressure, traverse(vm, valves, cache, rt, n, bitmask|bit)+valves[n].FlowRate*rt)
	}
	cache.addItem(time, valve, bitmask, pressure)
	return pressure
}
