package advent

import (
	"fmt"
	"image"
	"io"
	"strings"

	"github.com/cgravolet/adventofcode2022/pkg/utility"
)

type heightmap map[image.Point]int

func (a *AdventOfCode2022) Day12(input string) {
	hmap, start, end := makeHeightMap(strings.NewReader(input))
	part1 := findNearestPathInMap(hmap, start, end)
	fmt.Printf("Part 1: %d\n", part1)
}

func findNearestPathInMap(hmap heightmap, start image.Point, end image.Point) int {
	queue := []image.Point{start}
	visited := map[image.Point]bool{start: true}
	path := map[image.Point]image.Point{}

	for len(queue) > 0 {
		curpos := queue[0]
		queue = queue[1:]

		if curpos == end {
			pathArr := make([]image.Point, 0)
			prev, prevExists := path[curpos]
			for prevExists {
				pathArr = append(pathArr, prev)
				prev, prevExists = path[prev]
			}
			return len(pathArr)
		}
		neighbors := make([]image.Point, 4)
		neighbors[0] = image.Point{curpos.X - 1, curpos.Y}
		neighbors[1] = image.Point{curpos.X + 1, curpos.Y}
		neighbors[2] = image.Point{curpos.X, curpos.Y - 1}
		neighbors[3] = image.Point{curpos.X, curpos.Y + 1}

		for _, neighbor := range neighbors {
			_, isVisited := visited[neighbor]
			neighborHeight, isValid := hmap[neighbor]

			if !isVisited && isValid && neighborHeight <= hmap[curpos]+1 {
				queue = append(queue, neighbor)
				path[neighbor] = curpos
				visited[neighbor] = true
			}
		}
	}
	return -1
}

func makeHeightMap(r io.Reader) (heightmap, image.Point, image.Point) {
	hmap := make(heightmap)
	var start image.Point
	var end image.Point
	y := 0

	utility.ForEachLineInReader(r, func(s string) {
		for x, r := range s {
			h := int(r) - 96

			if h == -13 {
				start = image.Point{x, y}
				h = 0
			} else if h == -27 {
				end = image.Point{x, y}
				h = 27
			}
			hmap[image.Point{x, y}] = h
		}
		y++
	})
	return hmap, start, end
}
