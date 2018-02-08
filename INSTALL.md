# Installation

mvp is available as a conda package via bioconda, so it may be installed as follows:

```
$ conda install -c bioconda mvp
```

However, mvp is self-contained in one file, so it is essentially installed if it is somewhere on your `PATH`.
You then just need to ensure that you have the following dependencies installed:

* Python (either 2.7 or 3.x)
* Biopython
* pysam (>= 0.8.4)

# Running the tests

There is a small test suite that you can run using

```
$ make check
```

Verifying the output of the [examples](README.md#examples) is also a means of testing.
