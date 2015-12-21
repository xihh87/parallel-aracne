# ARACNE with HTCondor

For generate the Condor_submit File:

```
python /home/hachepunto/breast_cancer_networks/parallel_aracne/genera_condor.py \
	--aracne_tgz /home/hachepunto/ARACNE/ARACNE.src.tar.gz \
	--expfile_bz2 /home/hachepunto/rauldb/subclasificacion/her2_exp_matrix.txt.bz2 \
	--probes /home/hachepunto/rauldb/vaquerizas_plus2.txt \
	--run_id her2_1 \
	--outdir /home/hachepunto/rauldb/subclasificacion/her2_1 \
	--p 1
```

For submit the run_id.condor script:

    cd $outdir
    condor_submit run_id.condor

### Prune whit HT Condor

For generate the Condor_submit File:

```
python ~/breast_cancer_networks/parallel_aracne/genera_prune_condor.py \
	--adj ~/transfac_network/p1_adjs/AnimalTFDB_1.adj \
	--outdir ~/transfac_network/pruned_AnimalTFDB_1exp-10/ \
	--p 1e-10 \
	--n 880
```


where:

--adj = one or more adjacency files  

--outdir = directory to place condor scripts  

--p = P-value: e.g. 1e-7  

--n = sample size</p>  


In the console, a message return the value of MI which will be pruned network. For example:

      $ will generate prune scripts for mi=0.039708

For submit the run_id.condor script:

```
cd $outdir
condor_submit run_id.condor
```
