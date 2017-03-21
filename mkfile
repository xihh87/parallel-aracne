<config.mk

'results/001/(.*)\.(.*)\.adj':R:	'data/\1\.txt'
	mkdir -p `dirname $target`
	aracne \
		$ARACNE_OPTS \
		-h $stem2 \
		-i $prereq \
		-o $target".build" \
	&& mv $target".build" $target

results/001/%.genes:	data/%.txt
	mkdir -p `dirname $target`
	bin/genes \
		$prereq \
	> $target".build" \
	&& mv $target".build" $target
