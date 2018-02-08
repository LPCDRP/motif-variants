[![install with bioconda](https://img.shields.io/badge/install%20with-bioconda-brightgreen.svg?style=flat-square)](http://bioconda.github.io/recipes/mvp/README.html)

# NAME

mvp - detect creation/destruction of sequence motifs as a result of mutations

# DESCRIPTION

Sequence variation may cause the appearance or disappearance of certain motifs.
Since motifs can be recognition sites for biological functions such as regulation or DNA modification, their gain and loss can have additional consequences.

Using a list of variants in variant call format, the corresponding reference sequence, and a set of motifs to search for,**mvp** (motif-variant probe) identifies variants responsible for changing the number of occurrences of these motifs in the sequence.
**mvp** can process both nucleotide _and_ amino acid sequences.
For the latter, the variant call format is still used to represent the amino acid changes.
Motifs must be input using IUPAC ambiguity codes, simple regular expressions, or a combination of the two.

# EXAMPLES

See the help menu for usage information:

```
$ mvp --help
usage: mvp [-h] [-o OUTFILE] -r REFERENCE (-f MOTIF_FILE | -m MOTIF_LIST)
           [-t {dna,aa}]
           infile

Motif-Variant Probe: detect motif gain and loss due to mutations

positional arguments:
  infile                vcf or vcf.gz file containing mutations (default:
                        stdin)

optional arguments:
  -h, --help            show this help message and exit
  -o OUTFILE, --outfile OUTFILE
                        results table (default: stdout)
  -r REFERENCE, --reference REFERENCE
                        reference sequence in fasta format
  -f MOTIF_FILE, --motif-file MOTIF_FILE
                        file containing a list of motifs to check
  -m MOTIF_LIST, --motif-list MOTIF_LIST
                        a comma-delimited string of motifs to check
  -t {dna,aa}, --sequence-type {dna,aa}
                        DNA or amino acid (default: dna)
```

Process the example genomic data:

```
$ mvp -r reference.fasta -m gagtc,agcta,aagctc example.vcf  | column -t
motif   strand  position  reference  variant
GAGTC   +       85        1          0
AAGCTC  +       1243      1          0
AGCTA   +       905       0          1
AGCTA   -       905       0          1
```

If the strand is negative, the information corresponds to the partner motif.
`position` is that of the first VCF record in the set of variants responsible for the effect.
Multiple variants can be responsible for an effect if they are close enough together with respect to the length of the motif.
The number under `reference` is the number of occurrences of the motif in the reference segment, and likewise for the variant segment.
Thus, for the example above, we see that two of our motifs (GAGTC and AAGTC) had instances destroyed by mutations, while both AGCTA and its partner motif (TAGCT) were instantiated by variants around position 905 with respect to the reference sequence.


It is also possible to specify motifs using [IUPAC ambiguity codes](http://www.bioinformatics.org/sms/iupac.html), simple regular expressions, or a combination of the two.
This works for both DNA and amino acid sequences.

Running the same example as above, but making the same motifs a little more ambiguous:

```
$ mvp -r reference.fasta -m grbts,[ac]gcta,a[ac]dctc example.vcf  | column -t
motif            strand  position  reference  variant
G[AG][CGT]T[GC]  +       85        1          0
G[AG][CGT]T[GC]  -       85        1          1
A[AC][AGT]CTC    +       1243      1          0
[AC]GCTA         +       905       0          1
[AC]GCTA         -       905       0          1
```

We provided one motif using only the IUPAC codes, the second using a simple regular expression ([ac] meaning either A or C, which would correspond to M in the IUPAC code), and the third using a mix of the two.
The results are returned to us labeling all the motifs as simple regular expressions for consistency.

You can see now that we have now picked up more results due to our relaxing the motif specifications.
In particular, the second line showing a single occurrence of the partner motif for G[AG][CGT]T[GC] in both the reference and the variant can have multiple meanings.
Either it is the same motif unaffected by the variant's perturbation, or it may have shifted a bit along the sequence.

# CITATION

**mvp** was originally written for use in our [comparative genomics study of *Mycobacterium tuberculosis* virulent and attenuated strains](https://doi.org/10.1186/s12864-017-3687-5).
It does not yet have a publication of its own.
