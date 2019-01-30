module distribute_x(x_coords) {
	for (x = x_coords) {
		translate([x, 0])
		children();
	}
}

module distribute_y(y_coords) {
	for (y = y_coords) {
		translate([0, y])
		children();
	}
}
