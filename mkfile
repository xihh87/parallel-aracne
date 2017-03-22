<config.mk

'results/001/(.*)\.(.*)\.adj':R:	'data/\1\.txt'
	mkdir -p `dirname $target`
	aracne \
		$ARACNE_OPTS \
		-h $stem2 \
		-i $prereq \
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
	bin/rearrange_undirected_sif \
		$prereq \
	> $target".build" \
	&& mv $target".build" $target
