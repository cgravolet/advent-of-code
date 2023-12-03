default: test

benchmark:
	swift run -c release AdventOfCode --benchmark

build:
	swift build

fmt:
	swift package format-source-code

lint: fmt
	swift package lint-source-code

test: lint
	swift test

run:
	swift run