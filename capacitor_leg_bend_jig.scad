$fn=100;


// https://docs-apac.rs-online.com/webdocs/14e3/0900766b814e39c2.pdf

/** Capacitor Spec **/

// Capacitor Diameter
capd=16;

// Capacitor Length
capl=31;

// Capacitor Pin Spacing
cap_pin_spacing=7.5;


/** Object Spec **/
base_h=0.5;
leg_guide=1.5;


cap_radius=capd/2;

difference()
{
    cube([capd,capl,cap_radius+base_h]);
    
    // Cap Guide
    translate([cap_radius,leg_guide+1,cap_radius+base_h])
    rotate([-90,0,0])
    cylinder(r=capd/2, h=capl);
    
    // Cap Pin
    translate([cap_radius-cap_pin_spacing/2,leg_guide,cap_radius+base_h])
    rotate([-90,0,0])
    cylinder(r=0.5, h=4);
    
    translate([cap_radius+cap_pin_spacing/2,leg_guide,cap_radius+base_h])
    rotate([-90,0,0])
    cylinder(r=0.5, h=4);
    
    // Cap Bevel
    translate([cap_radius-cap_pin_spacing/2,leg_guide,cap_radius+base_h])
    rotate([-90,0,0])
    cylinder(r1=1, r2=0.5, h=0.5);
    
    translate([cap_radius+cap_pin_spacing/2,leg_guide,cap_radius+base_h])
    rotate([-90,0,0])
    cylinder(r1=1, r2=0.5, h=0.5);
    
    // Jig Ledge
    translate([0,0,base_h+cap_radius/2])
    cube([capd,leg_guide,cap_radius+base_h]);

    for(i=[-3:10])
    {
      translate([cap_radius-cap_pin_spacing/2+i*2.54/2 - 1/2,0,0])
      cube([1/2,leg_guide,base_h+100]);
    }
}
