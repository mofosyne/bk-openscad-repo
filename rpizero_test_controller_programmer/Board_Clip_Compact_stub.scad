// Compact Board clip
// For Raspberry Pi Zero Test Controller (Brian Khuu 2019)
// Remixed from https://www.thingiverse.com/thing:1520316/files Board clip by robidouille Apr 27, 2016

//hole = 2.8; // Arduino
hole = 2.5; // Raspberry Pi

marginT = 0.6; // Controls the size of the grip
marginB = marginT;
skirt = 1;
rise = 10;
bump = 1;
thick = 1;

slotAngle = 20;
slot = hole * sin(slotAngle);
shave = hole * (1 - cos(slotAngle));

eps = 0.1;

Repeat(2, 1, hole + marginB + skirt + 1, rise + rise + 1) translate([0, 0, hole/2 - shave]) rotate([-90, 0, 0]) HoleClip();

module Repeat(count_x, count_y, size_x, size_y) {
	for (i = [0 : count_x - 1]) {
		for (j = [0 : count_y - 1]) {
			translate([(i - (count_x - 1) / 2) * size_x, (j - (count_y - 1) / 2) * size_y - size_y/2, 0])
			children();
		}
	}
}

module HoleClip() {
  union()
  {
    difference() {
        union() {
            cylinder( d = hole + marginB, h = thick, $fn=20);
            cylinder( d1 = hole + marginB + skirt, d2 = hole + marginB - skirt, h = skirt * 2, $fn=20);
            translate([0, 0, thick - eps])
              cylinder(d = hole, h = rise + eps, $fn=20);
            translate([0, 0, rise + thick]) 
              cylinder(d1 = hole + marginT, d2 = hole - marginT, h = bump * 2, $fn=20);
        }
        
        // Slot Cut
        slot_depth = 7+bump*2; // Adjust based on material
        translate([-slot / 2, -(hole + marginB + eps)/2, rise + thick + bump * 2 - slot_depth+eps]) cube([slot, hole + marginB + eps, slot_depth]);
        
        translate([0, +(hole + marginB + eps)/2, rise + thick + bump * 2 - slot_depth+eps])
          rotate([90,0,0]) cylinder(r=(slot)/2, h = hole + marginB + eps, $fn=30);


        // Center Cut
        translate([0, 0, thick - eps])
          cylinder(d = hole/2, h = rise + bump * 2 + 2, $fn=20);

        // Top and bottom cut
        translate([-(hole + marginB + skirt)/2, hole*4/10 - shave, -eps]) 
          cube([hole + marginB + skirt, marginB + skirt, rise + thick+bump * 2+10]);
        translate([-(hole + marginB + skirt)/2, -hole/2 + shave - (marginB + skirt), rise/4]) 
          cube([hole + marginB + skirt, marginB + skirt, rise +  rise + eps * 2 + bump*2]);
    }
  }
}