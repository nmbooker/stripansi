all: stripansi

stripansi: stripansi.hs
	ghc -Wall --make stripansi.hs

clean:
	$(RM) stripansi stripansi.o stripansi.hi
