package advent

import (
	"fmt"
	"regexp"
	"strconv"
	"strings"

	"github.com/cgravolet/adventofcode2022/pkg/utility"
)

type Valve struct {
	Name        string
	FlowRate    int
	Connections []string
}

func (a *AdventOfCode2022) Day16(input string) {
	valves, first := parseInputDay16(input)
	part1 := solveDay16Part1(valves, first, 30)
	fmt.Printf("%d\n", part1)
}

func choosePath(valves map[string]Valve, pos string, time int) int {
	if time == 0 {
		return 0
	}
	return 0
}

func parseInputDay16(input string) (map[string]Valve, string) {
	var first string
	valveMap := make(map[string]Valve)

	utility.ForEachLineInReader(strings.NewReader(input), func(s string) {
		re := regexp.MustCompile(`Valve (\w{2}) has flow rate=(\d+); tunnels? leads? to valves? ([A-Z, ]+)`)
		matches := re.FindStringSubmatch(s)
		name := matches[1]
		rate, _ := strconv.Atoi(matches[2])
		valve := Valve{name, rate, []string{}}

		for _, c := range strings.Split(matches[3], ",") {
			valve.Connections = append(valve.Connections, strings.TrimSpace(c))
		}
		if len(first) == 0 {
			first = name
		}
		valveMap[name] = valve
	})
	return valveMap, first
}

func solveDay16Part1(valves map[string]Valve, first string, time int) int {
	sum := choosePath(valves, first, 30)
	return sum
}
