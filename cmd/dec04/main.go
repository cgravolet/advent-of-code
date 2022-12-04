package main

import (
	"fmt"
	"log"
	"os"

	"github.comcast.com/cgravo558/advent2022/pkg/utility"
)

type SectionRange struct {
	Start int
	End   int
}

func (s1 SectionRange) IsContainedBySection(s2 SectionRange) bool {
	return s1.Start >= s2.Start && s1.End <= s2.End
}

func (s1 SectionRange) IsOverlappedBySection(s2 SectionRange) bool {
	return !(s1.Start > s2.End || s1.End < s2.Start)
}

func makeSectionPairFromString(s string) (SectionRange, SectionRange, error) {
	var lhs, rhs SectionRange
	_, err := fmt.Sscanf(s, "%d-%d,%d-%d", &lhs.Start, &lhs.End, &rhs.Start, &rhs.End)
	return lhs, rhs, err
}

func main() {
	var contained int
	var overlapped int

	err := utility.ForEachLineInFile(os.Args[1], func(s string) {
		lhs, rhs, err := makeSectionPairFromString(s)

		if err != nil {
			return
		}

		if lhs.IsContainedBySection(rhs) || rhs.IsContainedBySection(lhs) {
			contained += 1
		}

		if lhs.IsOverlappedBySection(rhs) {
			overlapped += 1
		}
	})

	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("Contained sections (part 1): %d\n", contained)
	fmt.Printf("Overlapped sections (part 2): %d\n", overlapped)
}
