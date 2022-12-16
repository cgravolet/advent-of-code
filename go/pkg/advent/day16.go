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
	valveMap := parseInputDay16(input)
	fmt.Printf("%v\n", valveMap)
}

func parseInputDay16(input string) map[string]Valve {
	valveMap := make(map[string]Valve)

	utility.ForEachLineInReader(strings.NewReader(input), func(s string) {
		re := regexp.MustCompile(`Valve (\w{2}) has flow rate=(\d+); tunnels? leads? to valves? ([A-Z, ]+)`)
		matches := re.FindStringSubmatch(s)
		rate, _ := strconv.Atoi(matches[2])
		valve := Valve{rate, []string{}}

		for _, c := range strings.Split(matches[3], ",") {
			valve.Connections = append(valve.Connections, strings.TrimSpace(c))
		}
		valveMap[matches[1]] = valve
	})
	return valveMap
}
