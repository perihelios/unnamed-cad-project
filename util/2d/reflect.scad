module reflect_x() {
	children();
	mirror([0, 1]) children();
}

module reflect_y() {
	children();
	mirror([1, 0]) children();
}

module reflect_xy() {
	reflect_x() reflect_y() children();
}
