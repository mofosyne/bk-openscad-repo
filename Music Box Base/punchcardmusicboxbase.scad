$fn=20;

// Box dimentions
boxx = 65;
boxy = 50;
boxh = 5;

hs = 2.55;       // Hole Size in mm
isx = 10;        // inital spacing x
isy = 6;         // inital spacing y
a = 47.60  + hs; // x spacing
b = 35 + hs;     // y spacing

difference() {
cube([boxx,boxy,boxh]);
#translate([isx  , isy  , -1])cylinder(r=hs/2, h=boxh+2);
#translate([isx+a, isy  , -1])cylinder(r=hs/2, h=boxh+2);
#translate([isx  , isy+b, -1])cylinder(r=hs/2, h=boxh+2);
#translate([(boxx/4)  , -1, +2])cube([boxx/2,boxy+2,boxh*2/3]);
#translate([ -1 , (boxy/4), +2])cube([boxx+2,boxy/2,boxh*2/3]);
}
