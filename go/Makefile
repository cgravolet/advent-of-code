.DEFAULT_GOAL := build

fmt:
	go fmt ./...
.PHONY:fmt

test: vet
	go test ./...
.PHONY:test

vet: fmt
	go vet ./...
	# shadow ./...
.PHONY:vet

build: test
	go build -o bin ./...
.PHONY:build

install: test
	go install ./...
.PHONY:install
