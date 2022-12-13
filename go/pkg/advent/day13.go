package advent

import (
	"encoding/json"
	"fmt"
	"log"
	"strings"
)

func (a *AdventOfCode2022) Day13(input string) {
	part1, err := solveDay13Part1(input)

	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("Part 1: %d\n", part1)
}

func compareGroup(l, r []any) int {
	fmt.Printf("\t- Compare %v vs %v\n", l, r)

	if len(l) == 0 && len(r) > 0 {
		fmt.Printf("\t- Left side ran out of items, so inputs are in the right order\n")
		return 1 // Left side out of items, ordered correctly
	} else if len(l) > 0 && len(r) == 0 {
		fmt.Printf("\t- Right side ran out of items, so inputs are not in the right order\n")
		return -1 // Right side out of items, not ordered correctly
	}

	for len(l) > 0 {

		if len(r) == 0 {
			fmt.Printf("\t- Right side ran out of items, so inputs are not in the right order\n")
			return -1 // Right side out of items, not ordered correctly
		}
		lhs, rhs := l[0], r[0]
		l, r = l[1:], r[1:]
		lnum, lnumok := lhs.(float64)
		rnum, rnumok := rhs.(float64)

		if lnumok && rnumok {
			fmt.Printf("\t\t- Compare %d vs %d\n", int(lnum), int(rnum))

			if int(lnum) > int(rnum) {
				fmt.Printf("\t\t\t- Right side is smaller, so inputs are not in the right order\n")
				return -1 // Left side greater than right, not ordered correctly
			} else if int(lnum) < int(rnum) {
				fmt.Printf("\t\t\t- Left side is smaller, so inputs are in the right order\n")
				return 1 // Left side greater than right, not ordered correctly
			}
		} else {
			larr, larrok := lhs.([]any)
			rarr, rarrok := rhs.([]any)

			if larrok && rnumok {
				fmt.Printf("\t- Mixed types; convert right to [%f] and retry comparison\n", rnum)
				comparison := compareGroup(larr, []any{rnum})
				if comparison != 0 {
					return comparison
				}
			} else if lnumok && rarrok {
				fmt.Printf("\t- Mixed types; convert left to [%f] and retry comparison\n", lnum)
				comparison := compareGroup([]any{lnum}, rarr)
				if comparison != 0 {
					return comparison
				}
			} else if larrok && rarrok {
				comparison := compareGroup(larr, rarr)
				if comparison != 0 {
					return comparison
				}
			} else {
				panic(fmt.Errorf("Encountered unrecognized type %v", lhs))
			}
		}
	}

	if len(r) > 0 {
		fmt.Printf("\t- Left side ran out of items, so inputs are in the right order\n")
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
	fmt.Printf("Comparing %v vs %v\n", lqueue, rqueue)
	return compareGroup(lqueue, rqueue), nil
}

func decodePacket(packet string) ([]any, error) {
	var result []any
	err := json.Unmarshal([]byte(packet), &result)
	return result, err
}

func solveDay13Part1(input string) (int, error) {
	result := 0

	for i, pair := range strings.Split(input, "\n\n") {
		packets := strings.Split(pair, "\n")

		if len(packets) >= 2 {
			comparison, err := comparePackets(packets[0], packets[1])
			fmt.Printf("\tResult %v\n", comparison)

			if err != nil {
				return result, err
			} else if comparison == 1 {
				result += i + 1
			}
		}
	}
	return result, nil
}
