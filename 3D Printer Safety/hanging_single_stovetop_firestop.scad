$fn=20;

isx = 1.5;       // Inital Spacing X


/* Settings */
stfs_tolerance = 1; // Tolerance (screw head is large)
stfs_between_space = 25; // Spacing between
hang_holes = 2;   // Diameter of holes for the wall hanging string
hang_hole_interspace = 4; // Spacing between hanging holes
hang_to_stfs_space = 5; // Spacing between the hanging and stfs holes

/* STFS Dimentions */
stfs_head = 6.3; // Diameter of the screw head
stfs_holes = 2.7;   // Diameter of stovetop firestop retaining screws
stfs_b_dia = 85.23; // Diameter of stovetop firestop body
stfs_b_h = 55;      // Approx height of stovetop firestop body

/* Calc */
stfs_head_dia = stfs_head+stfs_tolerance+1;
stfs_hole_dia = stfs_holes+stfs_tolerance; // Alignment Pin Diamenter
hang_pin_dia = hang_holes; // Probe Pin Diameter

/* Hole Position */
ah1 = 0;
stfs_1_x = ah1 + hang_to_stfs_space;

ah2 = stfs_1_x + hang_to_stfs_space;

/* base */
boxx = ah1 + ah2;
boxy = 10;
boxh = 4;

/* 3D Model */
difference() {
hull() {
    translate([0  , 0  , 10])
        cylinder(r=stfs_head_dia/2, h=1);
    translate([0  , 0  , 0])
        cylinder(r=stfs_head_dia, h=1);
}

/* STFS 1 */
#translate([0 , 0  , -1])
    cylinder(r=stfs_hole_dia/2, h=10);
#translate([0 , 0  , 4])
    cylinder(r=stfs_head_dia/2, h=10);
%translate([0 , 0  , -stfs_b_h])
    cylinder(r=stfs_b_dia/2, h=stfs_b_h);

/* Mount Holes */
translate([0 , 0  , 8])
  rotate([90,0,0]) 
      cylinder(20, r=hang_pin_dia/2, center=true);

translate([0 , 0  , 8])
  rotate([90,0,90]) 
      cylinder(20, r=hang_pin_dia/2, center=true);

}
