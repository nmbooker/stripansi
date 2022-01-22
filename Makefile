all: stripansi

stripansi:
	cabal v2-build

clean:
	$(RM) -r stripansi dist-newstyle

.PHONY: clean stripansi
