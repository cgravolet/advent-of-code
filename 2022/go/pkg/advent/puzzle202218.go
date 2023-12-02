package advent

import (
	"fmt"
	"math"
	"strings"

	"github.com/cgravolet/adventofcode2022/pkg/utility"
)

type Point3D struct {
	X, Y, Z int
}

type Boundary struct {
	MaxX, MaxY, MaxZ, MinX, MinY, MinZ int
}

func (a *AdventOfCode2022) Puzzle202218(input string) {
	part1 := solvePuzzle202218Part1(input)
	part2 := solvePuzzle202218Part2(input)
	fmt.Printf("Part 1: %d\n", part1)
	fmt.Printf("Part 2: %d\n", part2)
}

// Parse

func parseInputPuzzle202218(input string) (points []Point3D, b Boundary) {
	b.MaxX, b.MaxY, b.MaxZ = math.MinInt, math.MinInt, math.MinInt
	b.MinX, b.MinY, b.MinZ = math.MaxInt, math.MaxInt, math.MaxInt
	utility.ForEachLineInReader(strings.NewReader(input), func(s string) {
		var x, y, z int
		_, err := fmt.Sscanf(s, "%d,%d,%d", &x, &y, &z)
		if err == nil {
			p := Point3D{x + 1, y + 1, z + 1}
			points = append(points, p)
			b.MaxX = int(math.Max(float64(b.MaxX), float64(p.X)))
			b.MaxY = int(math.Max(float64(b.MaxY), float64(p.Y)))
			b.MaxZ = int(math.Max(float64(b.MaxZ), float64(p.Z)))
			b.MinX = int(math.Min(float64(b.MinX), float64(p.X)))
			b.MinY = int(math.Min(float64(b.MinY), float64(p.Y)))
			b.MinZ = int(math.Min(float64(b.MinZ), float64(p.Z)))
		}
	})
	return
}

// Helper methods

func floodFill(graph [][][]int) [][][]int {
	queue := []Point3D{{0, 0, 0}}
	graph[0][0][0] = 2

	sides := []Point3D{{0, -1, 0}, {0, 1, 0}, {-1, 0, 0}, {1, 0, 0}, {0, 0, -1}, {0, 0, 1}}

	for len(queue) > 0 {
		p := queue[0]
		queue = queue[1:]

		for _, s := range sides {
			x, y, z := p.X+s.X, p.Y+s.Y, p.Z+s.Z

			if x >= 0 && y >= 0 && z >= 0 &&
				len(graph) > x && len(graph[x]) > y && len(graph[x][y]) > z &&
				graph[x][y][z] == 0 {
				queue = append(queue, Point3D{x, y, z})
				graph[x][y][z] = 2
			}
		}
	}
	return graph
}

func makeGraph(boundary Boundary) [][][]int {
	var graph [][][]int
	for x := 0; x <= boundary.MaxX+1; x++ {
		graph = append(graph, [][]int{})
		for y := 0; y <= boundary.MaxY+1; y++ {
			graph[x] = append(graph[x], []int{})
			for z := 0; z <= boundary.MaxZ+1; z++ {
				graph[x][y] = append(graph[x][y], 0)
			}
		}
	}
	return graph
}

// Solve

func solvePuzzle202218Part1(input string) int {
	points, b := parseInputPuzzle202218(input)
	graph := makeGraph(b)

	// Step 1: Add points to the graph
	for _, point := range points {
		graph[point.X][point.Y][point.Z] = 1
	}

	// Step 2: Count up the exposed sides for each point
	var sum int
	sides := []Point3D{{0, -1, 0}, {0, 1, 0}, {-1, 0, 0}, {1, 0, 0}, {0, 0, -1}, {0, 0, 1}}
	for _, p := range points {
		for _, s := range sides {
			x, y, z := p.X+s.X, p.Y+s.Y, p.Z+s.Z
			if graph[x][y][z] == 0 {
				sum++
			}
		}
	}
	return sum
}

func solvePuzzle202218Part2(input string) int {
	points, b := parseInputPuzzle202218(input)
	graph := makeGraph(b)

	// Step 1: Add points to the graph
	for _, point := range points {
		graph[point.X][point.Y][point.Z] = 1
	}

	// Step 2: Flood fill the graph
	graph = floodFill(graph)

	// Step 3: Count up the exposed sides for each point
	var sum int
	sides := []Point3D{{0, -1, 0}, {0, 1, 0}, {-1, 0, 0}, {1, 0, 0}, {0, 0, -1}, {0, 0, 1}}
	for _, p := range points {
		for _, s := range sides {
			x, y, z := p.X+s.X, p.Y+s.Y, p.Z+s.Z
			if graph[x][y][z] == 2 {
				sum++
			}
		}
	}
	return sum
}
