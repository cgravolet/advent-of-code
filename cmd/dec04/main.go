package main

import (
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"

	"github.comcast.com/cgravo558/advent2022/pkg/utility"
)

type Section struct {
	Start int
	End   int
}

func MakeSection(s string) (Section, error) {
	parameters := strings.Split(s, "-")
	section := Section{}

	if len(parameters) != 2 {
		return section, fmt.Errorf("Incorrect format")
	}
	start, err := strconv.Atoi(parameters[0])

	if err != nil {
		return section, err
	}
	end, err := strconv.Atoi(parameters[1])

	if err != nil {
		return section, err
	}
	section.Start = start
	section.End = end
	return Section{start, end}, nil
}

func (s1 Section) IsContainedBySection(s2 Section) bool {
	return s1.Start >= s2.Start && s1.End <= s2.End
}

func (s1 Section) IsOverlappedBySection(s2 Section) bool {
	return !(s1.Start > s2.End || s1.End < s2.Start)
}

func makeSectionPairFromString(s string) ([]Section, error) {
	sections := make([]Section, 0)
	for _, e := range strings.Split(s, ",") {
		sec, err := MakeSection(e)

		if err != nil {
			return nil, err
		}
		sections = append(sections, sec)
	}
	if len(sections) != 2 {
		return nil, fmt.Errorf("Expected 2 sections, got %d instead.", len(sections))
	}
	return sections, nil
}

func main() {
	var contained int
	var overlapped int

	err := utility.ForEachLineInFile(os.Args[1], func(s string) {
		sec, err := makeSectionPairFromString(s)

		if err != nil {
			return
		}

		if sec[0].IsContainedBySection(sec[1]) || sec[1].IsContainedBySection(sec[0]) {
			contained += 1
		}

		if sec[0].IsOverlappedBySection(sec[1]) {
			overlapped += 1
		}
	})

	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("Contained sections (part 1): %d\n", contained)
	fmt.Printf("Overlapped sections (part 2): %d\n", overlapped)
}
