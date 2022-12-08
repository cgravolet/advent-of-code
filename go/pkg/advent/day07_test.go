package advent

import (
	"reflect"
	"strings"
	"testing"
)

func TestFindSizeOfDirectoryForDeletion(t *testing.T) {
	dirmap := map[string]int{
		".":     584 + 29116 + 2557 + 62596 + 14848514 + 8504156 + 4060174 + 8033020 + 5626152 + 7214296,
		"./a":   584 + 29116 + 2557 + 62596,
		"./a/e": 584,
		"./d":   4060174 + 8033020 + 5626152 + 7214296,
	}
	want := 24933642
	got := findSizeOfDirectoryForDeletion(dirmap, 70000000, 30000000)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("\nexpected %d, got %d\n", want, got)
	}
}

func TestFindTotalSizeOfCandidatesForDeletion(t *testing.T) {
	dirmap := map[string]int{
		".":     584 + 29116 + 2557 + 62596 + 14848514 + 8504156 + 4060174 + 8033020 + 5626152 + 7214296,
		"./a":   584 + 29116 + 2557 + 62596,
		"./a/e": 584,
		"./d":   4060174 + 8033020 + 5626152 + 7214296,
	}
	want := 95437
	got := findTotalSizeOfCandidatesForDeletion(dirmap, 100000)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("\nexpected %d, got %d\n", want, got)
	}
}

func TestMakeDirMap(t *testing.T) {
	input := `$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k`

	got := makeDirMap(strings.NewReader(input))
	want := map[string]int{
		".":     584 + 29116 + 2557 + 62596 + 14848514 + 8504156 + 4060174 + 8033020 + 5626152 + 7214296,
		"./a":   584 + 29116 + 2557 + 62596,
		"./a/e": 584,
		"./d":   4060174 + 8033020 + 5626152 + 7214296,
	}

	if !reflect.DeepEqual(got, want) {
		t.Errorf("\nexpected: %v\ngot: %v\n", want, got)
	}
}
