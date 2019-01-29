module radial(r, steps, step_angle, start_angle, rotational_multiplier = 1) {
	for (i = [0 : steps - 1]) {
		tweak = start_angle == undef ? 0 : start_angle;
		angle = (step_angle == undef) ?
			360 * i / steps + tweak :
			i * step_angle + tweak;

		translate([r * cos(angle), r * sin(angle)])
			rotate(rotational_multiplier * angle)
			children();
	}
}
