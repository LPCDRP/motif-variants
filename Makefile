.ONESHELL:



check: \
 gerrymander-check \
 motif_len-check \
;

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

regex2iupac-check: SHELL=python
regex2iupac-check:
	@from __future__ import print_function
	import sys
	from motif_variants import regex2iupac
	status=0
	motifs = {
		"CTGGAG":"CTGGAG",
		"C[AC]AA[AC]TCA[AGCT]":"CMAAMTCAN",
		"[ACT][GT][GT]":"HKK",
	}
	for motif in motifs.keys():
	    expected = motifs[motif]
	    actual = regex2iupac(motif, 'dna')
	    if expected != actual:
	        print("FAIL: Expected IUPAC {} for regex {}. Got {}.".format(expected,motif,actual))
	        status=1
	if status == 0:
	    print("PASS: regex2iupac")
	sys.exit(status)

motif_revcomp-check: SHELL=python
motif_revcomp-check:
	@from __future__ import print_function
	import sys
	from motif_variants import motif_revcomp
	status=0
	motifs = {
		"CTGGAG":"CTCCAG",
		"C[AC]AA[AC]TCA[AGCT]":9,
		"[ACT][GT][GT]":3,
	}
	for motif in motifs.keys():
	    expected = motifs[motif]
	    actual = motif_len(motif)
	    if expected != actual:
	        print("FAIL: Expected length {} for motif {}. Got {}.".format(expected,motif,actual))
	        status=1
	if status == 0:
	    print("PASS: motif_len")
	sys.exit(status)

motif_len-check: SHELL=python
motif_len-check:
	@from __future__ import print_function
	import sys
	from motif_variants import motif_len
	status=0
	motifs = {
		"CTGGAG":6,
		"C[AC]AA[AC]TCA[AGCT]":9,
		"[ACT][GT][GT]":3,
	}
	for motif in motifs.keys():
	    expected = motifs[motif]
	    actual = motif_len(motif)
	    if expected != actual:
	        print("FAIL: Expected length {} for motif {}. Got {}.".format(expected,motif,actual))
	        status=1
	if status == 0:
	    print("PASS: motif_len")
	sys.exit(status)
