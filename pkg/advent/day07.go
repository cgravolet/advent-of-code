package advent

import (
	"fmt"
	"io"
	"sort"
	"strings"

	"github.com/cgravolet/adventofcode2022/pkg/utility"
)

func Day07(input string) {
	dirmap := makeDirMap(strings.NewReader(input))
	part1 := findTotalSizeOfCandidatesForDeletion(dirmap, 100000)
	part2 := findSizeOfDirectoryForDeletion(dirmap, 70000000, 30000000)
	fmt.Printf("Total size of candidates for deletion (part 1): %d\n", part1)
	fmt.Printf("Size of directory for deletion (part 2): %d\n", part2)
}

func findSizeOfDirectoryForDeletion(dirmap map[string]int, total int, required int) int {
	usedspace := dirmap["."]
	unusedspace := total - usedspace
	sizes := make([]int, 0)

	for _, s := range dirmap {
		sizes = append(sizes, s)
	}
	sort.Ints(sizes)

	for _, s := range sizes {
		if unusedspace+s >= required {
			return s
		}
	}
	return 0
}

func findTotalSizeOfCandidatesForDeletion(dirmap map[string]int, max int) int {
	var sum int
	for d, s := range dirmap {
		if d != "." && s <= max {
			sum += s
		}
	}
	return sum
}

func makeDirMap(r io.Reader) map[string]int {
	dirmap := map[string]int{".": 0}
	path := []string{"."}

	utility.ForEachLineInReader(r, func(s string) {
		var cd string
		_, err := fmt.Sscanf(s, "$ cd %s", &cd)

		if err == nil {
			switch cd {
			case "/":
				path = path[:1]
			case "..":
				path = path[:len(path)-1]
			default:
				path = append(path, cd)
			}
		} else {
			var fs int
			var fn string
			_, err := fmt.Sscanf(s, "%d %s", &fs, &fn)

			if err == nil {
				cp := make([]string, 0)
				for _, p := range path {
					cp = append(cp, p)
					dirmap[strings.Join(cp, "/")] += fs
				}
			}
		}
	})
	return dirmap
}
