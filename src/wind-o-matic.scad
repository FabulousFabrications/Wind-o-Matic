toroid_winder();

module toroid_winder() {
	standard_toroid_height = 140;
	wheel_diameter = 660;
	toroid_holder_offset = 350;
	
	// Example toroid
	translate([0, 0, toroid_holder_offset])
	#toroid(od=230, id=100, h=standard_toroid_height);

	// Bike wheel rim (with removed section)
	translate([-wheel_diameter/2, 0, toroid_holder_offset + standard_toroid_height/2])
	#wheel(wheel_diameter, 10, 10);

	// Toroid holders
	toroid_holders(count=3, distance=140, rod_d=12, holder_d=100, rod_h=toroid_holder_offset, holder_h=25, holder_h2=100, offset_r=0);
}

module wheel(d, h, w) {
	offset_angle = 40;
	rotate([90,-offset_angle/2,0]) rotate_extrude(angle=360-offset_angle) {
    	translate([d/2, 0, 0]) square([w, h]);
	}
}

module toroid(od, id, h) {
	rotate_extrude() translate([id/2, 0, 0]) square([(od-id)/2, h]);
}

module toroid_holders(count, distance, rod_d, holder_d, rod_h, holder_h, holder_h2, offset_R) {
	for (i = [0:count-1]) {
    	rotate([0,0,offset_r+360*i/count]) translate([distance,0,0]) toroid_holder(rod_d, holder_d, rod_h, holder_h, holder_h2);
	}
}

module toroid_holder(rod_d, holder_d, rod_h, holder_h, holder_h2) {
	// Steel rod
	#cylinder(d=rod_d, h=rod_h);
	translate([0,0,rod_h-holder_h]) toroid(id=rod_d, od=holder_d, h=holder_h);
	translate([0,0,rod_h]) toroid(id=rod_d, od=holder_d/2, h=holder_h2);
}
