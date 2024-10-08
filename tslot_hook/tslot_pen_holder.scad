$fn=100;
/*
    Parametric Cable Hooks For Tslot Mounting
    By Brian Khuu (2020)

    Got a desk with tslot rails, would be nice to mount cable on it...

    Inspired by https://www.thingiverse.com/thing:2676595 "V-Slot Cable Clips by pekcitron November 30, 2017"
*/

use <tslot.scad>

/* [Tslot Spec] */
// CenterDepth
tslot_centerdepth = 6.5;
// CenterWidth
tslot_centerwidth = 8; // Gap to slot the clip though
// For the wedge... its based on a 4040mm Tslot... so may need to modify polygon() in this script

/* [Pen Spec] */
pen_cup_hole_diameter=12; // Give bit extra for tolerance
pen_cup_hole_depth=90;

/* [Caliper Spec] */
caliper_rule_hole_thickness=5; // Typically 4mm but extra for tolerance

/* [Hook Spec (adapted... as a pen cup)] */
// Spacing between centerpoint
hookcenterspacing=10;
// Hook Diameter
hookdia=pen_cup_hole_diameter;
// Hook Width
hookwidth=tslot_centerwidth-1;
// Hook Thickness
hookthickness=1;

/* [Tslot Model] */
model_slot_gap = 10;
model_slot_side = 15;

translate([0, -1, 0])
union()
{
    // Tslot
    tslot(tslot_centerwidth=tslot_centerwidth);


    // Hook
    translate([0, -hookdia/2-hookthickness, 0])
    union()
    {
        difference()
        {
            union()
            {
                hull()
                {
                    translate([hookdia/2+hookcenterspacing/2,0,0])
                        cylinder(r=hookdia/2+hookthickness, h=pen_cup_hole_depth+hookthickness);
                    translate([-hookdia/2-hookcenterspacing/2,0,0])
                        cylinder(r=hookdia/2+hookthickness, h=pen_cup_hole_depth+hookthickness);
                }
                hull()
                {
                    translate([hookdia/2+hookcenterspacing/2,0,0])
                        cylinder(r=hookdia/2+hookthickness, h=hookwidth, center=true);
                    translate([-hookdia/2-hookcenterspacing/2,0,0])
                        cylinder(r=hookdia/2+hookthickness, h=hookwidth, center=true);
                }
            }
            hull()
            {
                hull()
                {
                    translate([hookdia/2+hookcenterspacing/2,0,0])
                        cylinder(r=caliper_rule_hole_thickness/2, h=pen_cup_hole_depth);
                    translate([-hookdia/2-hookcenterspacing/2,0,0])
                        cylinder(r=caliper_rule_hole_thickness/2, h=pen_cup_hole_depth);
                }
                hull()
                {
                    translate([hookdia/2+hookcenterspacing/2,0,0])
                        cylinder(r=hookdia/2, h=pen_cup_hole_depth-5);
                    translate([-hookdia/2-hookcenterspacing/2,0,0])
                        cylinder(r=hookdia/2, h=pen_cup_hole_depth-5);
                }
                hull()
                {
                    translate([hookdia/2+hookcenterspacing/2,0,0])
                        cylinder(r=hookdia/2, h=hookwidth+1, center=true);
                    translate([-hookdia/2-hookcenterspacing/2,0,0])
                        cylinder(r=hookdia/2, h=hookwidth+1, center=true);
                }
            }

            hull()
            {
                translate([hookdia/2+hookcenterspacing/2,0,0])
                    cylinder(r=caliper_rule_hole_thickness/2, h=pen_cup_hole_depth+2);
                translate([-hookdia/2-hookcenterspacing/2,0,0])
                    cylinder(r=caliper_rule_hole_thickness/2, h=pen_cup_hole_depth+2);
            }
        }
    }
}

%translate([model_slot_side/2+model_slot_gap/2,0,0]) cube([model_slot_side,0.1,100], center=true);
%translate([-model_slot_side/2-model_slot_gap/2,0,0]) cube([model_slot_side,0.1,100], center=true);
