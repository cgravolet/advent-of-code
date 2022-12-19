package advent

import (
	"fmt"
	"regexp"
	"strconv"
	"strings"

	"github.com/cgravolet/adventofcode2022/pkg/utility"
)

type Valve struct {
	FlowRate    int
	Connections []string
}

func (a *AdventOfCode2022) Day16(input string) {
	valves, first := parseInputDay16(input)
	choosePath(valves, first)
	fmt.Printf("%s %v\n", first, valves)
}

func choosePath(valves map[string]Valve, id string) {

}

func parseInputDay16(input string) (map[string]Valve, string) {
	var first string
	valveMap := make(map[string]Valve)

	utility.ForEachLineInReader(strings.NewReader(input), func(s string) {
		re := regexp.MustCompile(`Valve (\w{2}) has flow rate=(\d+); tunnels? leads? to valves? ([A-Z, ]+)`)
		matches := re.FindStringSubmatch(s)
		rate, _ := strconv.Atoi(matches[2])
		valve := Valve{rate, []string{}}

		for _, c := range strings.Split(matches[3], ",") {
			valve.Connections = append(valve.Connections, strings.TrimSpace(c))
		}
		if len(first) == 0 {
			first = matches[1]
		}
		valveMap[matches[1]] = valve
	})
	return valveMap, first
}
