<config.mk

# needed to use <(cmd) bashism, not posix
MKSHELL=/bin/bash

# Build the superior triangular matrix using aracne
# in adj format of the form:
#
#	gene1 <tab> gene2 <tab> mi [...] gene_n <tab> mi
#
'results/001/(.*)\.([0-9]+)\.(.*)\.adj':R:	'data/\1\.txt'	'results/001/\1.ok'
	mkdir -p `dirname $target`
	aracne \
		$ARACNE_OPTS \
		-h $stem3 \
		-i <(bin/sif-from-gene $stem2 'data/'$stem1'.txt') \
		-o $target".build" \
	&& mv $target".build" $target

# Check input file for repeated probes.
#
results/001/%.ok:Q:	data/%.txt
	mkdir -p `dirname $target`
	test `bin/genes-repetidos $prereq | wc -l` -eq 0 \
	&& touch $target \
	|| {
		printf "Colapsa las siguientes sondas en '$prereq':\n%s\n" \
		"`bin/genes-repetidos $prereq`"
		exit 1
	}

# Convert the multiple adj from aracne output
# into a sigle sif file of the form:
#
#	gene1 <tab> mi <tab> gene2
#
'results/002(.*/)([^/]*)\.sif':R:	'results/001\1'
	mkdir -p `dirname $target`
	EXPERIMENT=$stem2
	FILE="$EXPERIMENT"'.*.adj'
	find \
		$prereq \
		-name "$FILE" \
	| xargs bin/adj2sif \
	> $target".build" \
	&& mv $target".build" $target

# Filter repeats and self loops in sif.
#
# This step is superflous, because just the triangular matrix
# is calculated and aracne does not output self loops.
#
'results/003/%.sif':	'results/002/%.sif'
	mkdir -p `dirname $target`
	bin/no-repeats-in-sif \
		$prereq \
	> $target".build" \
	&& mv $target".build" $target

# Join all adj files from an experiment into one.
#
results/%.adj:	data/%.txt
	mkdir -p `dirname $target`
	# this xargs checks that all prerequisites are met
	# if this check fails, the build will not be completed.
	bin/input2adjs $prereq \
	| xargs awk '$1 !~ /^>/' \
	> $target".build" \
	&& mv $target".build" $target
