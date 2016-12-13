CRYSTAL := crystal
OS      := $(shell uname -s | tr '[:upper:]' '[:lower:]')
ARCH    := $(shell uname -m)

.PHONY: default install build test clean

default: install build

install:
	shards install

build:
	mkdir -p bin
	$(CRYSTAL) build src/jpholiday.cr -o bin/jpholidayc

test:
	crystal spec -v

clean:
	rm -rf .crystal
	rm -rf .shards
	rm -rf lib
