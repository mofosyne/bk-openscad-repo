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

module rpi_zero_hat_spacer()
{
  pcb_h = 1.5;
  module slot_cut(w,d,hpcbtosmd)
  {
    slot_h = hpcbtosmd - pcb_h; // height from bottom pcb to top of smd part
    translate([0,0,slot_h/2])
      cube([w, d, slot_h], center=true);
  }
  
  
  %translate([0,0,5])
  rpi_zero_bulk(pcb_h, 0.1); // PCB

  difference()
  {
    rpi_zero_bulk(pcb_h+5, 0.7); // Main Bulk
    
    rpi_zero_bulk(pcb_h+4, -0.5); // Inner Hollow For Electronics
    rpi_zero_bulk(pcb_h, 0.2); // PCB
    
    // (Special) OLED Hat SMD header pads is getting in the way
    #translate([29,23+3.5-1.5,5])
      rotate([0,90,0])
      cylinder(r=1.5, h=52, center=true);
    #translate([29,23+3.5-1.5-5,5])
      rotate([0,90,0])
      cylinder(r=1.5, h=52, center=true);
    
    // SD Card Slot
    #translate([0,(16.9-3.5),pcb_h])
      slot_cut(12,12, 2.9);

    // HDMI Slot
    #translate([(12.4-3.5),0,0])
      slot_cut(12,12,5+pcb_h);
    
    // USB Slot
    #translate([(41.4-3.5),0,0])
      slot_cut(9,9,4.5+pcb_h);
    
    // PWR USB Slot
    #translate([(54-3.5),0,0])
      slot_cut(9,9,4.5+pcb_h);
    
    // Flex Slot
    #translate([58,23/2,0])
      slot_cut(18,18,3+pcb_h);
  }
}

rotate([0,180,0])
rpi_zero_hat_spacer();