package utility

func Map[T, U any](data []T, f func(T) U) []U {
	res := []U{}
	for _, d := range data {
		res = append(res, f(d))
	}
	return res
}
