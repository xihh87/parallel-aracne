# ARACNE with HTCondor

To generate the Condor_submit File:

```
python /home/hachepunto/breast_cancer_networks/parallel_aracne/genera_condor.py \
	--aracne_tgz /home/hachepunto/ARACNE/ARACNE.src.tar.gz \
	--expfile_bz2 /home/hachepunto/rauldb/subclasificacion/her2_exp_matrix.txt.bz2 \
	--probes /home/hachepunto/rauldb/vaquerizas_plus2.txt \
	--run_id her2_1 \
	--outdir /home/hachepunto/rauldb/subclasificacion/her2_1 \
	--p 1
```



To submit the run_id.condor script:

```
cd $outdir
condor_submit run_id.condor
```

Sometimes jobs are held for unknown reasons, even though the .adj files are created they are empty.
To find the empty files:
```
find $outdir -empty -iname '*.adj'

```
