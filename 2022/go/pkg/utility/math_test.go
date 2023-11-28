package utility

import (
	"reflect"
	"testing"
)

func TestMaxInt(t *testing.T) {
	type test struct {
		lhs, rhs, want int
	}
	tests := []test{
		{2, 3, 3},
		{-30, 2, 2},
		{25, 7, 25},
		{59938, 4355, 59938},
	}

	for _, test := range tests {
		got := MaxInt(test.lhs, test.rhs)
		if !reflect.DeepEqual(test.want, got) {
			t.Errorf("expected %v, got %v", test.want, got)
		}
	}
}

func TestMinInt(t *testing.T) {
	type test struct {
		lhs, rhs, want int
	}
	tests := []test{
		{2, 3, 2},
		{-30, 2, -30},
		{25, 7, 7},
		{59938, 4355, 4355},
	}

	for _, test := range tests {
		got := MinInt(test.lhs, test.rhs)
		if !reflect.DeepEqual(test.want, got) {
			t.Errorf("expected %v, got %v", test.want, got)
		}
	}
}
