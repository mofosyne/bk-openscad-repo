$fn=100;
/*
    Parametric Hooks For Tslot Mounting
    By Brian Khuu (2020)

    Got a desk with tslot rails, would be nice to mount stuff on it...
*/

/* [Tslot Spec] */
// CenterDepth
tslot_centerdepth = 6.5;
// CenterWidth
tslot_centerwidth = 8; // Gap to slot the clip though
// For the wedge... its based on a 4040mm Tslot... so may need to modify polygon() in this script

/* [Hook Spec] */
// Hook Diameter
hookdia=10;
// Hook Flange
hookflange=3;
// Hook Width
hookwidth=7;
// Hook Thickness
hookthickness=4;

union()
{
    difference()
    {
        union()
        {
            // Tslot Mount Inner
            translate([0, tslot_centerdepth, 0])
                intersection()
                {
                    heightlim=7;
                    linear_extrude(height = hookwidth, center = true)
                        polygon(points=[[-10,0],[-5,8],[5,8],[10,0]]);
                    rotate([-90,0,0])
                        intersection()
                        {
                            hull()
                            {
                                translate([0,0,0]) cylinder(r=10, h=0.1);
                                translate([0,0,8]) cylinder(r=5, h=0.1);
                            }
                            union()
                            {
                                translate([0,0,heightlim/2+tslot_centerdepth/4])
                                    cube([20,20,heightlim-tslot_centerdepth/2], center = true);
                                intersection()
                                {
                                    rotate([0,90,0])
                                        translate([-tslot_centerdepth/2,0,0])
                                        cylinder(r=hookwidth/2, h=20, center = true);
                                    cube([20,20,hookwidth+1], center = true);
                                }
                            }
                        }
                }

            // tslot mount shaft
            translate([0, -hookthickness, 0])
            rotate([-90,0,0])
                intersection()
                {
                    cheight = tslot_centerdepth+hookthickness+hookwidth/2;
                    union()
                    {
                        cylinder(r=tslot_centerwidth/2, h=cheight);
                        translate([-hookwidth/2+1, 0, hookthickness-hookthickness/2])
                            cube([tslot_centerwidth,hookwidth,hookthickness], center=true);
                    }
                    translate([0, 0, cheight/2])
                        cube([tslot_centerwidth+10, hookwidth, cheight], center=true);
                }
        }

        //
        translate([0, 100/2, 0])
            cube([2,100,100], center=true);

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
                cylinder(r=hookdia/2+hookthickness, h=hookwidth, center=true);
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
                translate([hookdia/2+hookthickness/2,0,0])
                    cylinder(r=hookthickness/2, h=hookwidth, center=true);
                translate([hookdia/2+hookthickness/2+hookflange,hookflange,0])
                    cylinder(r=hookthickness/2, h=hookwidth, center=true);
            }
    }
}
