$fn = 100;

/*
  This is a calibration object, to help with printing header probes that requires accuracy
  in the z axis.
  
  To calibrate, try printing this object. 
  If it printed properly, you can fit your standard pin headers to the holes.
  
  If not then measure the longest length. It is 40mm in max height, so if your printer
  calibrates via a 20x20x20mm cube. Then half the 40mm to get the z height calibration result.
  
  40mm is chosen to help make the 20mm cube data entry more accurate after divison by 2.
  
*/

/* Currently Assuming Imperial Header Size */
header_width = 0.65;
header_spacing = 2.54;
tolerance = 0.5;

module header_hole_calibration(header_width, header_spacing, tolerance)
{
  x_count = 20;
  header_length = 20;

  module female_header_req(hw, hl, tol)
  {
      union()
      {
          #translate([-(hw+tol)/2,-(hw+tol)/2,-1])
              cube([hw+tol,hw+tol,hl+2]);
          
          /* Male Header Visualisation */
          %union()
          {
              translate([-(hw)/2,-(hw)/2,-3-2.5]) color("grey")
                  cube([hw,hw,hl+3+2.5]);
              translate([0,0,-(header_spacing)/2])
                  cube([header_spacing,header_spacing,(2.5)],  center=true);
          }
      }
  }
  
  difference()
  {
    union()
    {
      translate([0, -20/2, 0]) 
        cube([40,20,1]);
      translate([0, -20/2, 20-1]) 
        cube([20,20,1]);
      translate([0, -20/2, 0]) 
        cube([1,20,20]);
    }
    
    /* Cutout */
    for ( xi = [0 : 1 : (40/header_spacing)] )
      translate([header_spacing/4+header_spacing*xi, 0, 0]) 
        female_header_req(header_width, header_length, tolerance);
  }
}

rotate([0,-90,-90])
header_hole_calibration(header_width, header_spacing, tolerance);

