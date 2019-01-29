module reflect(v = [1, 0]) {
	children();
	mirror(v) children();
}

module reflect_xy() {
	reflect([0, 1]) reflect() children();
}
