$fn=20;

isx = 1.5;       // Inital Spacing X


/* Settings */
stfs_tolerance = 1; // Tolerance (screw head is large)
stfs_between_space = 25; // Spacing between
hang_holes = 2;   // Diameter of holes for the wall hanging string
hang_hole_interspace = 4; // Spacing between hanging holes
hang_to_stfs_space = 5; // Spacing between the hanging and stfs holes

/* STFS Dimentions */
stfs_holes = 2.7;   // Diameter of stovetop firestop retaining screws
stfs_b_dia = 85.23; // Diameter of stovetop firestop body
stfs_b_h = 55;      // Approx height of stovetop firestop body

/* Calc */
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
union() {
    translate([0  , -boxy/2  , 0])
        cube([boxx,boxy,boxh]);
    translate([0  , 0  , 0])
        cylinder(r=boxy/2, h=boxh);
    translate([boxx  , 0  , 0])
        cylinder(r=boxy/2, h=boxh);
}

/* Align Hole 1 */
#translate([ah1 ,  hang_hole_interspace/2 , -1])
    cylinder(r=hang_holes/2, h=boxh+2);
#translate([ah1 , -hang_hole_interspace/2 , -1])
    cylinder(r=hang_holes/2, h=boxh+2);

/* STFS 1 */
#translate([stfs_1_x , 0  , -1])
    cylinder(r=stfs_hole_dia/2, h=boxh+2);
%translate([stfs_1_x , 0  , -stfs_b_h])
    cylinder(r=stfs_b_dia/2, h=stfs_b_h);

/* Align Hole 2 */
#translate([ah2 ,  hang_hole_interspace/2 , -1])
    cylinder(r=hang_holes/2, h=boxh+2);
#translate([ah2 , -hang_hole_interspace/2 , -1])
    cylinder(r=hang_holes/2, h=boxh+2);
}
