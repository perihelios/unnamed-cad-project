use <util/2d/distribute.scad>;
use <util/2d/hole.scad>;
use <util/2d/radial.scad>;
use <util/2d/reflect.scad>;
use <util/2d/shape.scad>;
use <util/unit.scad>;

$fn=100;

color("silver")
	linear_extrude(ft2mm(10))
	channel40x80();

module channel40x80() {
	difference() {
		rounded_rect(80, 40, 3);

		reflect_y()
			translate([20, 0])
			circle(3.5, true);

		reflect_y()
			translate([-20, 0])
			radial(20, 3, 90, start_angle = 90)
			rotate(-90)
			mountingCutout();

		diamondCutout();

		reflect_xy()
			translate([0, 20])
			distribute_x([4 : 8 : 36])
			circle(0.5);

		reflect_xy()
			translate([40, 0])
			distribute_y([0, 8, 16])
			circle(0.5);
	}
}

module diamondCutout() {
	height = 31;
	width = 25;
	middleHeight = 11;
	radius = 2;

	hull() reflect_xy() {
		translate([0, height / 2 - radius])
			circle(radius);

		translate([width / 2 - radius, middleHeight / 2 - radius])
			circle(radius);
	}
}

module mountingCutout() {
	holeDiameter = 8;
	holeDepth = 4.5;

	wellDepth = 8;
	
	module well(depth) {
		wideLength = 22;
		wideRadius = 0.75;
		
		narrowLength = 11.5;
		narrowRadius = 2.5;

		vWideOffset = depth - wideRadius - narrowRadius;
		hWideOffset = wideLength / 2 - wideRadius;

		hNarrowOffset = narrowLength / 2 - narrowRadius;

		hull()
			reflect_y()
			translate([0, narrowRadius]) {
				translate([hWideOffset, vWideOffset])
					circle(wideRadius);

				translate([hNarrowOffset, 0])
					circle(narrowRadius);
			}
	}
	
	translate([0, -(wellDepth + holeDepth)])
		well(wellDepth);

	translate([0, -holeDepth / 2])
		hole_chamfer(holeDiameter, holeDepth);
}
