# mk-aracne

The pipeline run by [CSB-IG](http://csbig.inmegen.gob.mx/ "Computational Systems Biology/Integrative Genomics")
to make aracne adjs with p=1.

This pipeline computes the superior diagonal of the adj only.
You should transform your files to the format required for further analyses.

# Running a job

You should add to the `data` directory your files
containing the expression matrices in the format:

```
genes <tab> sample1 <tab> ... <tab> sample_n
```

- The first line should be the header.

- The expression matrix filename(s) must end with `.txt`

Then execute:

```
bin/targets | xargs mk
```

The expression value of each probe will be colapsed by mean,
alphabetically sorted and placed in `results/001/`.

The adj for each probe will be placed at `results/002/`
but may be joined into a single [sif](#sif) or [adj](#adj).

You can edit the parameters to run aracne with by editing `config.mk`.

## ADJ output {#adj}

To join every probe for an experiment into one file:

```
bin/target-adjs | xargs mk
```

## SIF output {#sif}

To transform every probe for an experiment into one sif file:

```
bin/target-sifs | xargs mk
```

# Requirements

- [`mk`](http://doc.cat-v.org/bell_labs/mk/mk.pdf "A succesor for `make`."):
    For running the jobs.

- [`R`](http://www.r-project.org/ "Language and environment for statistical computing and graphics") 3.3:
    For colapsing the expression matrices by mean.
    All required libraries are provided in this repository.

- [`awk`](http://www.gnu.org/software/gawk/ "A minilanguage for text analysis."):
    For knowing which jobs to run.

- [ARACNe](http://califano.c2b2.columbia.edu/aracne/ "Algorithm for the Reconstruction of Accurate Cellular Networks"):
    The whole point of this pipeline.

    The binary file should be on your PATH and be named `aracne` (not `aracne2`).
    As the binary needs modifications to be installed correctly on your PATH,
    you can use a script containing:

    ```
    #!/bin/sh
    /path/to/aracne2 -H "@"
    ```

    We use aracne 2 as published as of march 2017:
    87ab986280492fab1058b9f8bfb411d5  ARACNE.src.tar.gz
