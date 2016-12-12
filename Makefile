CRYSTAL := crystal
OS      := $(shell uname -s | tr '[:upper:]' '[:lower:]')
ARCH    := $(shell uname -m)

.PHONY: default install clean build

default: install build

install:
	shards install

build:
	mkdir -p bin
	$(CRYSTAL) build src/jpholiday.cr -o bin/jpholidayc

clean:
	rm -rf .crystal
	rm -rf .shards
	rm -rf lib
