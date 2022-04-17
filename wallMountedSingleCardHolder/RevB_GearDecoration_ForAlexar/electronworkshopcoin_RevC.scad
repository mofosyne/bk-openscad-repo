use <MCAD/involute_gears.scad>
use <MCAD/regular_shapes.scad>

$fn=40;
minLine=0.8;
layerH=0.3 + 0.1;

coinTotalH=layerH*3;
coinBaseH=layerH*1.5;

module outerRing()
{
    h = coinTotalH;
    w = 9;
    l = 9;
    t = minLine;
    difference()
    {
        oval_prism(h, l, w);
        translate([0,0,-0.5])
        oval_prism(h+1, l-t, w-t);
    }
}

module electronRing()
{
    h = coinTotalH;
    w = 3;
    l = 7;
    t = minLine;
    difference()
    {
        oval_prism(h, l, w);
        translate([0,0,-0.5])
            oval_prism(h+1, l-t, w-t);
    }
}

module electron_workshop_coin()
{
    intersection()
    {
        gear(number_of_teeth=22, circular_pitch=200, hub_thickness=0, bore_diameter = 20, rim_thickness = coinTotalH);
        cylinder(r=12.5, h=100);
    }
    
    outerRing();

    rotate([0,0,0])
        electronRing();
    rotate([0,0,55])
        electronRing();
    rotate([0,0,-55])
        electronRing();

    intersection()
    {
        sr = coinTotalH;
        translate([0,0,coinBaseH/2])
            sphere(r=sr);
        translate([0,0,sr])
            cube([sr*2,sr*2,sr+1], center=true);
    }
    
    cylinder(r=10, h=coinBaseH);
}

electron_workshop_coin();

