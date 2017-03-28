<config.mk

# needed to use <(cmd) bashism, not posix
MKSHELL=/bin/bash

# Build the superior triangular matrix using aracne
# in adj format of the form:
#
#	gene1 <tab> gene2 <tab> mi [...] gene_n <tab> mi
#
'results/002/(.*)\.([0-9]+)\.(.*)\.adj':R:	'results/001/\1.txt'
	mkdir -p `dirname $target`
	aracne \
		$ARACNE_OPTS \
		-h $stem3 \
		-i <(bin/sif-from-gene $stem2 $prereq) \
		-o $target".build" \
	&& mv $target".build" $target

# Colapse by average repeated probes.
#
results/001/%.txt:Q:	data/%.txt
	mkdir -p `dirname $target`
	bin/colapsa $prereq > $target'.build' \
	&& mv $target'.build' $target

# Convert the multiple adj from aracne output
# into a sigle sif file of the form:
#
#	gene1 <tab> mi <tab> gene2
#
results/%.sif:	data/%.txt
	mkdir -p `dirname $target`
	# this xargs checks that all prerequisites are met
	# if this check fails, the build will not be completed.
	bin/input2adjs $prereq \
	| xargs bin/adj2sif \
	> $target".build" \
	&& mv $target".build" $target \
	|| {
		echo "Some files are missing. Please run the default target first."
		exit 1
	}


# Join all adj files from an experiment into one.
#
results/%.adj:	data/%.txt
	mkdir -p `dirname $target`
	# this xargs checks that all prerequisites are met
	# if this check fails, the build will not be completed.
	bin/input2adjs $prereq \
	| xargs awk '$1 !~ /^>/' \
	> $target".build" \
	&& mv $target".build" $target \
	|| {
		echo "Some files are missing. Please run the default target first."
		exit 1
	}
