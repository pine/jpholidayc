CRYSTAL := crystal
OS      := $(shell uname -s | tr '[:upper:]' '[:lower:]')
ARCH    := $(shell uname -m)

ifeq ($(OS),linux)
	CRFLAGS := --link-flags "-static -L$(shell crenv prefix)/embedded/lib"
endif

ifeq ($(OS),darwin)
	CRFLAGS := --link-flags "-L."
endif

.PHONY: default install build test clean

default: install build

install:
	shards install

build:
	mkdir -p bin
	$(CRYSTAL) build src/jpholiday.cr -o bin/jpholidayc

release:
	mkdir -p bin
	$(CRYSTAL) build --release $(CRFLAGS) src/jpholiday.cr -o bin/jpholidayc
	cd bin && tar cvfz jpholidayc_$(shell bin/jpholidayc -v)_$(OS)_$(ARCH).tar.gz jpholidayc

test:
	crystal spec -v

clean:
	rm -rf .crystal
	rm -rf .shards
	rm -rf lib
