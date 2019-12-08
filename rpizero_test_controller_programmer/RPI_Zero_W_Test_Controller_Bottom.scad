$fn=20;
// Openscad Raspberry Pi Zero W Test Controller Top
// Author: Brian Khuu 2019
// Note: Dimentions based on https://blog.protoneer.co.nz/raspberry-pi-zero-footprint-dimensions/

module rpi_zero_bulk(h_mm, outset)
{
  header_tol = 1;
  hole_tol = 1;

  difference()
  {
    union()
    {
      hull()
      {
        translate([0,0,0])
          cylinder(r=3.5+outset,h=h_mm);
        translate([0,23,0])
          cylinder(r=3.5+outset,h=h_mm);
        translate([58,0,0])
          cylinder(r=3.5+outset,h=h_mm);
        translate([58,23,0])
          cylinder(r=3.5+outset,h=h_mm);
      }
    }

    // Header
    translate([29,23,+h_mm/2])
      cube([51+header_tol,5+header_tol,h_mm], center=true);
    
    // Holes
    translate([0,0,-1])
      cylinder(r=((2.75+hole_tol)/2),h=h_mm+2);
    translate([0,23,-1])
      cylinder(r=((2.75+hole_tol)/2),h=h_mm+2);
    translate([58,0,-1])
      cylinder(r=((2.75+hole_tol)/2),h=h_mm+2);
    translate([58,23,-1])
      cylinder(r=((2.75+hole_tol)/2),h=h_mm+2);
  }
}

module rpi_zero_hat_bottom()
{
  %rpi_zero_bulk(1, 0);
  rpi_zero_bulk(0.5, 0.7);
}

rpi_zero_hat_bottom();