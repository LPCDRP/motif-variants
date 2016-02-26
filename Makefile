.ONESHELL:



check: gerrymander-check

gerrymander-check: SHELL=python
gerrymander-check: gerrymander-test.vcf
	import pysam
	from motif_variants import gerrymander
	infile = pysam.VariantFile('$<', 'r')
	districts = gerrymander(infile, 6)
	for district in districts:
	    print "-"*10
	    for block in district:
	        print block.pos
