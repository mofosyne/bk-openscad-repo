$fn=100;
/*
Customizable Capacitor leg bending tool
Brian Khuu 2019

This assist in bending capacitor legs in a consistent manner.

Default Values based on a 30F Supercap https://docs-apac.rs-online.com/webdocs/14e3/0900766b814e39c2.pdf

*/


/** Capacitor Spec **/

// Capacitor Diameter
capd=16;

// Capacitor Length
capl=31;

// Capacitor Pin Spacing
cap_pin_spacing=7.5;

/** Object Spec **/

// Base Height
base_h=10;

// Leg Guide Length
leg_guide=5;

/** Pin Offset **/

// Pin offset of left leg
pin_offset_1 = 1;

// Pin offset of right leg
pin_offset_2 = 0;

// Pin Pitch Increment
pin_pitch = 2.54;

/* Calc */
cap_radius=capd/2;

difference()
{
    cube([capd,capl,cap_radius+base_h+1]);
    
    // Cap Guide
    translate([cap_radius,leg_guide+2,cap_radius+base_h])
    rotate([-90,0,0])
    cylinder(r=capd/2, h=capl);
    
    // Cap Pin
    translate([cap_radius-cap_pin_spacing/2,leg_guide,cap_radius+base_h])
    union()
    {
      rotate([-90,0,0])
        cylinder(r=0.5, h=4);
      translate([-0.5,-0.5,0])
        cube([1,4,2]);
    }

    translate([cap_radius+cap_pin_spacing/2,leg_guide,cap_radius+base_h])
    union()
    {
      rotate([-90,0,0])
        cylinder(r=0.5, h=4);
      translate([-0.5,-0.5,0])
        cube([1,4,2]);
    }
    
    // Cap Bevel
    translate([cap_radius-cap_pin_spacing/2,leg_guide,cap_radius+base_h])
    rotate([-90,0,0])
    cylinder(r1=1, r2=0.5, h=1);
    
    translate([cap_radius+cap_pin_spacing/2,leg_guide,cap_radius+base_h])
    rotate([-90,0,0])
    cylinder(r1=1, r2=0.5, h=1);
    
    // Jig Ledge
    translate([0,0,base_h+cap_radius/3])
    cube([capd,leg_guide,cap_radius+base_h]);

    // Pin Gap
    hull()
    {
      translate([cap_radius-cap_pin_spacing/2 - 1/2 + pin_offset_1*pin_pitch,0,0])
        cube([1,leg_guide,base_h+cap_radius/2]);        
      translate([cap_radius+cap_pin_spacing/2 - 1/2 + pin_offset_2*pin_pitch,0,0])
        cube([1,leg_guide,base_h+cap_radius/2]);
    }
}
