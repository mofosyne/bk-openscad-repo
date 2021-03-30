$fn=100;
/*
    Parametric Hooks For Tslot Mounting
    By Brian Khuu (2020)

    Got a desk with tslot rails, would be nice to mount stuff on it...
*/

use <tslot.scad>

/* [Tslot Spec] */
// CenterDepth
tslot_centerdepth = 6.5;
// CenterWidth
tslot_centerwidth = 10; // Gap to slot the clip though
// For the wedge... its based on a 4040mm Tslot... so may need to modify polygon() in this script

/* [Hook Spec] */
// Hook Diameter
hookdia=10;
// Hook Flange
hookflange=3;
// Hook Width
hookwidth=9;
// Hook Thickness
hookthickness=4;

module tslotHook()
{
    union()
    {
        // Tslot
        tslot();

        // Hook
        difference()
        {
            union()
            {
                // tslot mount shaft
                translate([0, -hookthickness, 0])
                rotate([-90,0,0])
                    intersection()
                    {
                        cheight = tslot_centerdepth+hookthickness+hookwidth/2;
                        union()
                        {
                            cylinder(r=tslot_centerwidth/2, h=hookthickness);
                            translate([-(tslot_centerwidth+3)/4, 0, 1/2])
                                cube([(tslot_centerwidth+3)/2,hookwidth,1], center=true);
                        }
                        translate([0, 0, cheight/2])
                            cube([tslot_centerwidth, hookwidth, cheight], center=true);
                    }
            }
        }

        // Hook
        translate([-hookdia/2-1, -hookdia/2-hookthickness, 0])
        rotate([0,0,-90])
        translate([0,0,0])
        union()
        {
            translate([0, 0, 0])
                difference()
                {
                    union()
                    {
                        translate([0,0,-hookwidth/4])
                            cylinder(r2=hookdia/2+hookthickness, r1=hookdia/2+1, h=hookwidth/2, center=true);
                        translate([0,0,hookwidth/4])
                            cylinder(r1=hookdia/2+hookthickness, r2=hookdia/2+1, h=hookwidth/2, center=true);
                    }
                    translate([0,0,0])
                        cylinder(r=hookdia/2, h=hookwidth+2, center=true);
                    translate([0,hookdia/2,0])
                        cube([hookdia,hookdia,hookwidth+2], center=true);
                    translate([hookdia/2,hookdia/2,0])
                        cube([hookdia,hookdia,hookwidth+2], center=true);
                }
                
                translate([0, 0, 0])
                hull()
                {
                    translate([0,0,+hookwidth/2])
                        union()
                        {
                            translate([hookdia/2+0.5,0,0])
                                cylinder(r=0.5, h=0.001, center=true);
                            translate([hookdia/2+0.5,hookflange,0])
                                cylinder(r=0.5, h=0.001, center=true);
                        }
                    translate([0,0,-hookwidth/2])
                        union()
                        {
                            translate([hookdia/2+0.5,0,0])
                                cylinder(r=0.5, h=0.001, center=true);
                            translate([hookdia/2+0.5,hookflange,0])
                                cylinder(r=0.5, h=0.001, center=true);
                        }
                    translate([0,0,0])
                        union()
                        {
                            #translate([hookdia/2+0.5,0,0])
                                cylinder(r=0.5, h=0.001, center=true);
                            #translate([hookdia/2+0.5,hookflange,0])
                                cylinder(r=0.5, h=0.001, center=true);
                            #translate([hookdia/2+hookthickness+0.5-1,0,0])
                                cylinder(r=0.5, h=0.001, center=true);
                        }
                }
        }
    }
}

// Hook Stack
if (1)
{ 
    for(i = [0:1:4])
    {
        layerGapSpacing = 0.50;
        translate([0,0,i*(hookwidth+layerGapSpacing)])
            tslotHook();
    }
}