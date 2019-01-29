use <util/unit.scad>;
use <util/2d/shape.scad>;
use <util/2d/reflect.scad>;
use <util/2d/radial.scad>;

$fn=100;

color("silver")
	linear_extrude(ft2mm(10))
	channel40x80();

module channel40x80() {
	difference() {
		rounded_rect(80, 40, 3);
		
		reflect() {
			translate([20, 0]) circle(3.5, true);
		}

		translate([-20, 0]) radial(20, 3, 90, start_angle = 90) rotate(-90) {
			mountingCutout();
		}

		diamondCutout();

		translate([20, 0]) radial(20, 3, 90, start_angle = -90) rotate(-90) {
			mountingCutout();
		}
		
		reflect([0, 1])
		for (i = [-40 + 4 : 8 : 40]) {
			translate([i, 20])
				circle(0.5);
		}
		
		reflect()
		for (i = [-20 + 4 : 8 : 20]) {
			translate([-40, i])
				circle(0.5);
		}
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
		
		hull() reflect() {
			translate([0, narrowRadius]) {
				translate([hWideOffset, vWideOffset])
					circle(wideRadius);

				translate([hNarrowOffset, 0])
					circle(narrowRadius);
			}
		}
	}
	
	module hole(diameter, depth, chamferingRadius = 1, chamferingOffset = 0.1) {
		hChamferOffset = diameter / 2 + chamferingRadius;
		vChamferOffset = depth / 2 - chamferingRadius * (1 - chamferingOffset);
				
		translate([0, -depth / 2]) {
			difference() {
				square([diameter + chamferingRadius * 2, depth], true);
				
				hull() {
					translate([-hChamferOffset, vChamferOffset])
						circle(chamferingRadius);

					translate([-hChamferOffset, -vChamferOffset])
						circle(chamferingRadius);
				}

				hull() {
					translate([hChamferOffset, vChamferOffset])
						circle(chamferingRadius);

					translate([hChamferOffset, -vChamferOffset])
						circle(chamferingRadius);
				}
			}
		}

	}
	
	translate([0, -(wellDepth + holeDepth)])
		well(wellDepth);
	hole(holeDiameter, holeDepth);
}
