package advent

import (
	"image"
	"reflect"
	"strings"
	"testing"
)

var sample12 = `Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi
`

func TestPuzzle202212FindNearestPathInMap(t *testing.T) {
	hmap, start, end := makeHeightMap(strings.NewReader(sample12))
	want := 31
	wantshortest := 29
	got, gotshortest, ok := findNearestPathInMap(hmap, start, end)

	if !ok {
		t.Errorf("Path not found.")
	}

	if !reflect.DeepEqual(want, got) {
		t.Errorf("\nexpected %d, got %d\n", want, got)
	}

	if !reflect.DeepEqual(wantshortest, gotshortest) {
		t.Errorf("\nexpected %d, got %d\n", want, got)
	}
}

func TestPuzzle202212MakeHeightMap(t *testing.T) {
	wantstart := image.Point{0, 0}
	wantend := image.Point{5, 2}
	got, gotstart, gotend := makeHeightMap(strings.NewReader(sample12))

	if !reflect.DeepEqual(len(got), 40) {
		t.Errorf("\nexpected\n%d\n\ngot\n%d\n\n", 40, len(got))
	}

	if !reflect.DeepEqual(wantstart, gotstart) {
		t.Errorf("\nexpected\n%d\n\ngot\n%d\n\n", wantstart, gotstart)
	}

	if !reflect.DeepEqual(got[wantstart], 1) {
		t.Errorf("\nexpected\n%d\n\ngot\n%d\n\n", 1, got[wantstart])
	}

	if !reflect.DeepEqual(wantend, gotend) {
		t.Errorf("\nexpected\n%d\n\ngot\n%d\n\n", wantend, gotend)
	}

	if !reflect.DeepEqual(got[wantend], 26) {
		t.Errorf("\nexpected\n%d\n\ngot\n%d\n\n", 26, got[wantend])
	}
}
