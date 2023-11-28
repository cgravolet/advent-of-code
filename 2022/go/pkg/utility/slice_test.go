package utility

import (
	"reflect"
	"testing"
)

func TestInsertElement(t *testing.T) {
	input := []int{1, 4, 2, 0, -2, -9, 7}
	want := []int{1, 4, 3, 2, 0, -2, -9, 7}
	got, _ := InsertElement(input, 3, 2)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}

func TestMoveElement(t *testing.T) {
	input := []int{3, -8, 0, 6, 5, 2}
	want := []int{3, -8, 2, 0, 6, 5}
	got, _ := MoveElement(input, 5, 2)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}

	got, _ = MoveElement(got, 0, 5)
	want = []int{-8, 2, 0, 6, 5, 3}

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}

	got, _ = MoveElement(got, 1, 4)
	want = []int{-8, 0, 6, 5, 2, 3}

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}

func TestRemoveElement(t *testing.T) {
	input := []int{1, 4, 2, 0, -2, -9, 7}
	want := []int{1, 4, 0, -2, -9, 7}
	got, _, _ := RemoveElement(input, 2)

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}

func TestSliceIndex(t *testing.T) {
	input := []int{1, 3, 2, 5, 0, 2, 4, -3, -9, 8}
	want := 4
	got := SliceIndex(len(input), func(i int) bool {
		return input[i] == 0
	})

	if !reflect.DeepEqual(want, got) {
		t.Errorf("expected %v, got %v", want, got)
	}
}
