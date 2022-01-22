all: stripansi

stripansi:
	@ echo "Makefile is deprecated - use cabal v2-build instead" >&2
	cabal v2-build

clean:
	$(RM) -r stripansi dist-newstyle

.PHONY: clean stripansi
