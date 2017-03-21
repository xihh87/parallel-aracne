<config.mk

'results/001/(.*)\.(.*)\.adj':R:	'data/\1\.txt'
	mkdir -p `dirname $target`
	aracne \
		$ARACNE_OPTS \
		-h $stem2 \
		-i $prereq \
		-o $target".build" \
	&& mv $target".build" $target

'results/002/(.*)\.sif':R:	'results/001/'
	mkdir -p `dirname $target`
	EXPERIMENTO=$stem1
	ARCHIVO="$EXPERIMENTO"'.*.adj'
	find \
		$stem1 \
		-name "$ARCHIVO" \
	| xargs bin/adj2sif \
	> $target".build" \
	&& mv $target".build" $target
