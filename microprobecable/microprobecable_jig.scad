// Mill-Max 852-10-010-10-003000 probe soldering jig

tol = 0.1; // 0.1 Tight Grip

// Manual measure of Mill-Max 852-10-010-10-003000 10pin micro header
header_xmm = tol + 3;
header_ymm = tol + 6.8;
header_cup_pin_depth_mm = 4.6;
header_pin_jig_mm = 6;

// Folded IDC cable 10 pin
idc_cable_h = 6;
idc_cable_w = 2.5;

if(1)
difference()
{
  union()
  {
    hull()
    {
      cube([header_xmm*4, header_ymm*2, 0.1], center=true);
      translate([0,0,header_pin_jig_mm-0.1])
        cube([header_xmm*2, header_ymm*2, 0.1], center=true);
    }
    cube([header_xmm*20, header_ymm*3, 0.6], center=true);
  }
  
  #translate([0,0,header_pin_jig_mm/2+ 0.3])
    cube([header_xmm, header_ymm+1, header_pin_jig_mm], center=true);

  #translate([0,0,header_pin_jig_mm/2 + 0.3])
    cube([1, header_ymm*3, header_pin_jig_mm], center=true);
}

