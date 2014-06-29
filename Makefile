all: stripansi

stripansi: stripansi.hs
	ghc --make stripansi.hs

clean:
	$(RM) stripansi stripansi.o stripansi.hi
