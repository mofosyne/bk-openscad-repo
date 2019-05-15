// Mill-Max 852-10-010-10-003000 probe shroud
$fn = 20;
tol = 0.2;

// Manual measure of Mill-Max 852-10-010-10-003000 10pin micro header
header_xmm = 3;
header_ymm = 6.8;
header_cup_pin_depth_mm = 4.6;
header_pin_jig_mm = 6;
header_plastic_depth = 2.5; // measured 1.9

// Folded IDC cable 10 pin
idc_cable_h = 7; // 6mm
idc_cable_w = 1.8; // 2.5

// Shroud 
sthick = 2;
sdepth = 6;
shroud_header_l = 40;
shroud_cable_l = 5;
shroud_ledge = 0.5; // Transition between plastic and the metal solder cups (Measured to be 0.6mm)

shroud_lock_thickness = 1;

module probe_cap()
{
  cap_x = tol + header_xmm+sthick;
  cap_y = tol*1.5 + header_ymm+sthick;
  union()
  {
    linear_extrude(height = 10, convexity = 10)
    {
      difference()
      {
        union()
        {
          translate([0,0,0]) square([shroud_lock_thickness+cap_x, shroud_lock_thickness+cap_y], center=true);
          
          
        }
        translate([0,0,0])
          square([cap_x, cap_y], center=true);
      }
    }
  // Top Cut
  translate([0,(tol*1.5 + header_ymm+sthick)/2,shroud_header_l/2])
    cube([tol + header_xmm+sthick, 2, (shroud_header_l)], center=true);
  }
}

module probe_shroud()
{
  //%probe_cap();
  
//translate([0,0,shroud_header_l + shroud_cable_l])
rotate([90,0,0])
difference()
{
  case_depth = shroud_header_l+shroud_cable_l-0.1;

  union()
  { 
    translate([0,0,case_depth/2])
    cube([tol + header_xmm+sthick, tol*1.5 + header_ymm+sthick, case_depth], center=true);
  }
  
  // Header Probe Insert
  #translate([0,0,header_plastic_depth/2+0.5])
    cube([tol + header_xmm, tol + header_ymm, header_plastic_depth], center=true);
  
  translate([0,header_ymm/2,header_plastic_depth/2+0.5])
    cylinder(r = (header_xmm+sthick)/2-0.3, h = header_plastic_depth, center=true);
  
  // Top Cut
  translate([0,(header_ymm+sthick)/2,shroud_header_l/2])
    cube([tol + header_xmm+sthick, 2, (shroud_header_l)], center=true);

  // cutout
  //translate([0,0,0])
  //  cube([header_ymm/8, header_ymm*2, (header_plastic_depth*4)*2], center=true);
  
  // Extra Space for soldered cable to slide
  hull()
  {
    cutoutx = header_xmm;
    translate([0,0,header_plastic_depth/2+header_plastic_depth])
      cube([tol + cutoutx, tol + header_ymm, 0.2], center=true);
    translate([0,0,header_plastic_depth/2+0.5+header_plastic_depth+10])
      cube([tol + cutoutx, tol + header_ymm, 0.2], center=true);
    
 
    translate([0,5,header_plastic_depth/2+header_plastic_depth])
      cube([tol + cutoutx+0.5, tol + header_ymm, 0.2], center=true);
    translate([0,5,header_plastic_depth/2+0.5+header_plastic_depth+10])
      cube([tol + cutoutx+0.5, tol + header_ymm, 0.2], center=true);
  }
  
  // Shroud Header Holes
  translate([0,0,0])
    cube([tol/2 + header_xmm-shroud_ledge, tol/2 + header_ymm-shroud_ledge, shroud_header_l*2], center=true);
  translate([0,5,0])
    cube([tol/2 + header_xmm-shroud_ledge, tol/2 + header_ymm-shroud_ledge, shroud_header_l*2], center=true);
  
  // Shroud cable
  #translate([0,0,shroud_header_l+shroud_cable_l/2])
    cube([tol+idc_cable_w, tol+idc_cable_h, shroud_cable_l], center=true);
}
}

probe_shroud();

//translate([10,0,0])
//probe_cap();