package advent

import (
	"image"
	"reflect"
	"strings"
	"testing"
)

var day12sample = `Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi

`

func TestDay12FindNearestPathInMap(t *testing.T) {
	hmap, start, end := makeHeightMap(strings.NewReader(day12sample))
	want := 31
	got := findNearestPathInMap(hmap, start, end)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("\nexpected %d, got %d\n", want, got)
	}
}

func TestDay12MakeHeightMap(t *testing.T) {
	wantstart := image.Point{0, 0}
	wantend := image.Point{5, 2}
	got, gotstart, gotend := makeHeightMap(strings.NewReader(day12sample))

	if !reflect.DeepEqual(len(got), 40) {
		t.Errorf("\nexpected\n%d\n\ngot\n%d\n\n", 40, len(got))
	}

	if !reflect.DeepEqual(wantstart, gotstart) {
		t.Errorf("\nexpected\n%d\n\ngot\n%d\n\n", wantstart, gotstart)
	}

	if !reflect.DeepEqual(got[wantstart], 0) {
		t.Errorf("\nexpected\n%d\n\ngot\n%d\n\n", 0, got[wantstart])
	}

	if !reflect.DeepEqual(wantend, gotend) {
		t.Errorf("\nexpected\n%d\n\ngot\n%d\n\n", wantend, gotend)
	}

	if !reflect.DeepEqual(got[wantend], 27) {
		t.Errorf("\nexpected\n%d\n\ngot\n%d\n\n", 0, got[wantend])
	}
}
