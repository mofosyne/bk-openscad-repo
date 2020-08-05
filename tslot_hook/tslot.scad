$fn=100;
/*
    Parametric Headphone Mount For Tslot Mounting
    By Brian Khuu (2020)

    Got a desk with tslot rails, would be nice to screwdriver on it...
*/

/* [Tslot Spec] */
// CenterDepth
//tslot_centerdepth = 6.5;
// CenterWidth
//tslot_centerwidth = 8; // Gap to slot the clip though
// For the wedge... its based on a 4040mm Tslot... so may need to modify polygon() in this script
/* [Hook Calc] */
// Hook Width
//hookwidth=7;

module tslot(tslot_centerdepth = 7, tslot_centerwidth = 8, hookwidth=7, standoff=3)
{
    tslot_centerdepth = tslot_centerdepth + standoff;
    difference()
    {
        union()
        {
            // Tslot Mount Inner
            translate([0, tslot_centerdepth, 0])
                intersection()
                {
                    heighttrim=0.1;
                    heightlim=6;
                    es=0.5;
                    linear_extrude(height = hookwidth, center = true)
                        polygon(points=[[-10-es,0],[-5-es,8],[5+es,8],[10+es,0]]);
                    rotate([-90,0,0])
                        intersection()
                        {
                            union()
                            {
                                ext=2;
                                translate([0,0,hookwidth/2 +ext/2])
                                    cube([20+es*2,20,ext], center = true);
                                intersection()
                                {
                                    rotate([0,90,0])
                                        translate([-hookwidth/2,0,0])
                                        cylinder(r=hookwidth/2, h=20, center = true);
                                    cube([20-0.5,20,hookwidth], center = true);
                                }
                            }
                        }
                }

            // tslot mount shaft
            translate([0, 0, 0])
            rotate([-90,0,0])
                intersection()
                {
                    cheight = tslot_centerdepth+hookwidth/2+1;
                    cylinder(r=tslot_centerwidth/2, h=cheight);
                    translate([0, 0, cheight/2])
                        cube([tslot_centerwidth-2, hookwidth, cheight], center=true);
                }

            // Base
            translate([0, 0, 0])
            rotate([-90,0,0])
                hull()
                {
                    translate([0, 0, standoff])
                    intersection()
                    {
                        cheight = tslot_centerdepth+hookwidth/2+1;
                        cylinder(r=tslot_centerwidth/2, h=1);
                        translate([0, 0, standoff/2])
                            cube([tslot_centerwidth-2, hookwidth, 1], center=true);
                    }
                    intersection()
                    {
                        cheight = tslot_centerdepth+hookwidth/2+1;
                        cylinder(r=tslot_centerwidth/2, h=1);
                        translate([0, 0, standoff/2])
                            cube([tslot_centerwidth, hookwidth, standoff], center=true);
                    }
                }
        }

        // Split
        translate([0, 100/2+standoff, 0])
            cube([2,100,100], center=true);

    }
}


module tslotOrg(tslot_centerdepth = 6.5, tslot_centerwidth = 8, hookwidth=7, standoff=2)
{
    tslot_centerdepth = tslot_centerdepth + standoff;
    difference()
    {
        union()
        {
            // Tslot Mount Inner
            translate([0, tslot_centerdepth, 0])
                intersection()
                {
                    heightlim=6;
                    es=1;
                    linear_extrude(height = hookwidth, center = true)
                        polygon(points=[[-10-es,0],[-5-es,8],[5+es,8],[10+es,0]]);
                    rotate([-90,0,0])
                        intersection()
                        {
                            union()
                            {
                                translate([0,0,heightlim/2+tslot_centerdepth/4])
                                    cube([20+es*2,20,heightlim-tslot_centerdepth/2], center = true);
                                intersection()
                                {
                                    rotate([0,90,0])
                                        translate([-tslot_centerdepth/2,0,0])
                                        cylinder(r=hookwidth/2, h=20+es*2, center = true);
                                    cube([20+es*2-1,20,hookwidth+es*2], center = true);
                                }
                            }
                        }
                }

            // tslot mount shaft
            translate([0, , 0])
            rotate([-90,0,0])
                intersection()
                {
                    cheight = tslot_centerdepth+hookwidth/2+1;
                    cylinder(r=tslot_centerwidth/2, h=cheight);
                    translate([0, 0, cheight/2])
                        cube([tslot_centerwidth+10, hookwidth, cheight], center=true);
                }
        }

        // Split
        translate([0, 100/2+standoff, 0])
            cube([2,100,100], center=true);

    }
}

/* [Tslot Model] */
model_slot_gap = 10;
model_slot_side = 15;

%translate([model_slot_side/2+model_slot_gap/2,0,0]) cube([model_slot_side,0.1,100], center=true);
%translate([-model_slot_side/2-model_slot_gap/2,0,0]) cube([model_slot_side,0.1,100], center=true);

//%tslotOrg();
tslot();