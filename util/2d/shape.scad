use <reflect.scad>;

module rounded_rect(w, h, r) {
	hull() reflect_xy() translate([w / 2 - r, h / 2 - r]) circle(r);
}
