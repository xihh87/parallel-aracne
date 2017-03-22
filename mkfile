<config.mk

MKSHELL=/bin/bash

'results/001/(.*)\.([0-9]+)\.(.*)\.adj':R:	'data/\1\.txt'	'results/001/\1.ok'
	mkdir -p `dirname $target`
	aracne \
		$ARACNE_OPTS \
		-h $stem3 \
		-i <(bin/sif-from-gene $stem2 'data/'$stem1'.txt') \
		-o $target".build" \
	&& mv $target".build" $target

'results/002(.*/)([^/]*)\.sif':R:	'results/001\1'
	mkdir -p `dirname $target`
	EXPERIMENTO=$stem2
	ARCHIVO="$EXPERIMENTO"'.*.adj'
	find \
		$prereq \
		-name "$ARCHIVO" \
	| xargs bin/adj2sif \
	> $target".build" \
	&& mv $target".build" $target

'results/003/%.sif':	'results/002/%.sif'
	mkdir -p `dirname $target`
	bin/no-repeats-in-sif \
		$prereq \
	> $target".build" \
	&& mv $target".build" $target

results/001/%.ok:Q:	data/%.txt
	mkdir -p `dirname $prereq`
	test  `bin/genes-repetidos $prereq | wc -l` -eq 0 \
	&& touch $target \
	|| {
		printf "Colapsa los siguientes genes en '$prereq':\n%s\n" \
		"`bin/genes-repetidos $prereq`"
		exit 1
	}
