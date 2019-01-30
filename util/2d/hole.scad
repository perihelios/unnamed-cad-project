use <reflect.scad>;

module hole_chamfer(width, depth, chamfer_radius = 1, chamfer_offset = 0.1) {
	offset_x = width / 2 + chamfer_radius;
	offset_y = depth / 2 - chamfer_radius * (1 - chamfer_offset);

	difference() {
		square([width + chamfer_radius * 2, depth], true);

		reflect_y()
			translate([offset_x, 0])
			hull()
			reflect_x()
			translate([0, offset_y])
			circle(chamfer_radius);
	}
}
