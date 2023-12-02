package advent

import (
	"fmt"
	"image"
	"io"
	"strings"

	"github.com/cgravolet/adventofcode2022/pkg/utility"
)

type heightmap map[image.Point]int

func (a *AdventOfCode2022) Puzzle202212(input string) {
	hmap, start, end := makeHeightMap(strings.NewReader(input))
	part1, part2, ok := findNearestPathInMap(hmap, start, end)

	if ok {
		fmt.Printf("Part 1: %d\n", part1)
		fmt.Printf("Part 2: %d\n", part2)
	} else {
		fmt.Println("Path not found")
	}
}

func findNearestPathInMap(hmap heightmap, start image.Point, end image.Point) (int, int, bool) {
	q := []image.Point{end}
	path := map[image.Point]image.Point{}
	shortest := -1
	visited := map[image.Point]bool{end: true}

	for len(q) > 0 {
		curpos := q[0]
		q = q[1:]

		if curpos == start {
			return getPathLength(path, curpos), shortest, true
		} else if hmap[curpos] == 1 && shortest == -1 {
			shortest = getPathLength(path, curpos)
		}
		neighbors := make([]image.Point, 4)
		neighbors[0] = image.Point{curpos.X - 1, curpos.Y}
		neighbors[1] = image.Point{curpos.X + 1, curpos.Y}
		neighbors[2] = image.Point{curpos.X, curpos.Y - 1}
		neighbors[3] = image.Point{curpos.X, curpos.Y + 1}

		for _, n := range neighbors {
			_, isVisited := visited[n]
			nheight, isValid := hmap[n]

			if !isVisited && isValid && nheight >= hmap[curpos]-1 {
				q = append(q, n)
				path[n] = curpos
				visited[n] = true
			}
		}
	}
	return -1, shortest, false
}

func getPathLength(path map[image.Point]image.Point, p image.Point) int {
	pathArr := make([]image.Point, 0)
	prev, prevExists := path[p]

	for prevExists {
		pathArr = append(pathArr, prev)
		prev, prevExists = path[prev]
	}
	return len(pathArr)
}

func makeHeightMap(r io.Reader) (heightmap, image.Point, image.Point) {
	var start image.Point
	var end image.Point
	hmap := make(heightmap)
	y := 0

	utility.ForEachLineInReader(r, func(s string) {
		for x, r := range s {
			h := int(r) - 96

			if h == -13 {
				start = image.Point{x, y}
				h = 1
			} else if h == -27 {
				end = image.Point{x, y}
				h = 26
			}
			hmap[image.Point{x, y}] = h
		}
		y++
	})
	return hmap, start, end
}
