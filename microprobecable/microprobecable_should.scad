// Mill-Max 852-10-010-10-003000 probe soldering jig
$fn = 10;
tol = 0.1;

// Manual measure of Mill-Max 852-10-010-10-003000 10pin micro header
header_xmm = tol + 3;
header_ymm = tol + 6.8;
header_cup_pin_depth_mm = 4.6;
header_pin_jig_mm = 6;
header_plastic_depth = 2;

// Folded IDC cable 10 pin
idc_cable_h = 6;
idc_cable_w = 2.5;

// Shroud 
sthick = 1;
sdepth = 6;
shroud_header_l = 10;
shroud_cable_l = 10;
should_ledge = 0.4; // Transition between plastic and the metal solder cups (Measured to be 0.6mm)

rotate([90,0,0])
difference()
{
  union()
  {
    hull()
    {
      cube([header_xmm+sthick, header_ymm+sthick, 0.1], center=true);
      
      // Probe Shroud
      translate([0,0,shroud_header_l-0.1])
        cube([header_xmm+sthick, header_ymm+sthick, 0.1], center=true);
      
      // Cable Shroud
      translate([0,0,shroud_header_l+shroud_cable_l-0.1])
        cube([idc_cable_w, header_ymm+sthick, 0.1], center=true);
      
      // Direction Indicator
      translate([0,header_ymm/2 + 1,0])
        cylinder(r=1, h= 1);
    }
  }
  
  translate([0,0,0])
    cube([header_xmm, header_ymm, header_plastic_depth*2], center=true);
  
  translate([0,0,0])
    cube([header_xmm-should_ledge, header_ymm-should_ledge, shroud_header_l*2], center=true);
  
  translate([0,0,0])
    cube([idc_cable_w, idc_cable_h, shroud_header_l*2 + shroud_cable_l*2], center=true);
}

