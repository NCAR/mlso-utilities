.PHONY: install

PREFIX=$(HOME)

install:
	cd bin; make install PREFIX=$(PREFIX)
