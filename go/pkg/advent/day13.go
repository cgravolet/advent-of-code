package advent

import (
	"encoding/json"
	"fmt"
	"log"
	"reflect"
	"sort"
	"strings"

	"github.com/cgravolet/adventofcode2022/pkg/utility"
)

func (a *AdventOfCode2022) Day13(input string) {
	part1, err := day13part1(input)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("Part 1: %d\n", part1)

	part2, err := day13part2(input)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("Part 2: %d\n", part2)
}

func day13part1(input string) (int, error) {
	result := 0

	for i, pair := range strings.Split(input, "\n\n") {
		packets := strings.Split(pair, "\n")

		if len(packets) >= 2 {
			comparison, err := comparePackets(packets[0], packets[1])

			if err != nil {
				return result, err
			} else if comparison == 1 {
				result += i + 1
			}
		}
	}
	return result, nil
}

func day13part2(input string) (int, error) {
	packets := make([][]any, 0)

	utility.ForEachLineInReader(strings.NewReader(input), func(s string) {
		if len(s) > 0 {
			var packet []any
			err := json.Unmarshal([]byte(s), &packet)
			if err == nil {
				packets = append(packets, packet)
			}
		}
	})

	dividerPacket1 := []any{[]any{2.0}}
	dividerPacket2 := []any{[]any{6.0}}
	packets = append(packets, dividerPacket1, dividerPacket2)

	sort.Slice(packets, func(l, r int) bool {
		return compareGroup(packets[l], packets[r]) > 0
	})

	key := 1

	for i, p := range packets {
		if reflect.DeepEqual(p, dividerPacket1) || reflect.DeepEqual(p, dividerPacket2) {
			key *= (i + 1)
		}
	}
	return key, nil
}

// Internal methods

func compareGroup(l, r []any) int {
	if len(l) == 0 && len(r) > 0 {
		return 1
	} else if len(l) > 0 && len(r) == 0 {
		return -1
	}

	for len(l) > 0 {

		if len(r) == 0 {
			return -1
		}
		lhs, rhs := l[0], r[0]
		l, r = l[1:], r[1:]
		lnum, lnumok := lhs.(float64)
		rnum, rnumok := rhs.(float64)

		if lnumok && rnumok {
			if int(lnum) > int(rnum) {
				return -1
			} else if int(lnum) < int(rnum) {
				return 1
			} else {
				continue
			}
		}
		larr, larrok := lhs.([]any)
		rarr, rarrok := rhs.([]any)

		if larrok && rnumok {
			if comparison := compareGroup(larr, []any{rnum}); comparison != 0 {
				return comparison
			}
		} else if lnumok && rarrok {
			if comparison := compareGroup([]any{lnum}, rarr); comparison != 0 {
				return comparison
			}
		} else if larrok && rarrok {
			if comparison := compareGroup(larr, rarr); comparison != 0 {
				return comparison
			}
		} else {
			panic(fmt.Errorf("encountered unrecognized type %v", lhs))
		}
	}

	if len(r) > 0 {
		return 1
	}
	return 0
}

func comparePackets(l, r string) (int, error) {
	lqueue, lerr := decodePacket(l)
	rqueue, rerr := decodePacket(r)

	if lerr != nil {
		return -1, lerr
	} else if rerr != nil {
		return -1, rerr
	}
	return compareGroup(lqueue, rqueue), nil
}

func decodePacket(packet string) ([]any, error) {
	var result []any
	err := json.Unmarshal([]byte(packet), &result)
	return result, err
}
