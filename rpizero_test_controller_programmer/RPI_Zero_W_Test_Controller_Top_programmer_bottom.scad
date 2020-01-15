$fn=20;
// Openscad Raspberry Pi Zero W Test Controller Top (Programmer)
// Author: Brian Khuu 2019
// Note: Dimentions based on https://blog.protoneer.co.nz/raspberry-pi-zero-footprint-dimensions/

module rpi_zero_bulk(h_mm, outset, cutout = false)
{
  header_tol = 1;
  hole_tol = 0.5;

  difference()
  {
    union()
    {
      hull()
      {
        translate([0,0,0])
          cylinder(r=3.5+outset,h=h_mm);
        translate([0,23.5,0])
          cylinder(r=3.5+outset,h=h_mm);
        translate([58+2,0,0])
          cylinder(r=3.5+outset,h=h_mm);
        translate([58+2,23.5,0])
          cylinder(r=3.5+outset,h=h_mm);
      }
    }

    if (cutout)
    {
        // M3 holes = 2.75
        holedia = 3+hole_tol;
        
        // Header
        //translate([29,23,+h_mm/2])
        //  cube([51+header_tol,5+header_tol,h_mm+0.1], center=true);
        
        // Holes
        translate([1,0,-1])
          cylinder(r=((holedia)/2),h=h_mm+2);
        translate([1,23,-1])
          cylinder(r=((holedia)/2),h=h_mm+2);
        translate([58+1,0,-1])
          cylinder(r=((holedia)/2),h=h_mm+2);
        translate([58+1,23,-1])
          cylinder(r=((holedia)/2),h=h_mm+2);
    }
  }
}

module rpi_zero_hat_case()
{
  base_mm = 6;
  side_wall_mm = 16;
    
  pcb_h = 2;
  pcb_standoff = 2;
  
    // align hole
    if (0)
    {
        translate([0,0,base_mm])
        {
            xhole_tol = -0.9;
            xh_mm = 3;
            xdia = 1.8;
            translate([0,0,-1])
              cylinder(r=((xdia)/2),h=xh_mm+2);
            translate([0,23,-1])
              cylinder(r=((xdia)/2),h=xh_mm+2);
            translate([58,0,-1])
              cylinder(r=((xdia)/2),h=xh_mm+2);
            translate([58,23,-1])
              cylinder(r=((xdia)/2),h=xh_mm+2);
        }
    }

  difference()
  {
    rpi_zero_bulk(base_mm+pcb_standoff+side_wall_mm, 2, true); // Main Bulk
    
    translate([0,0,base_mm+pcb_standoff]) 
      rpi_zero_bulk(side_wall_mm+4, 0.7); // Inner Hollow For Electronics
    
    // pcb ledge
    translate([0,0,base_mm]) 
      rpi_zero_bulk(side_wall_mm+4, -0.5);
    difference()
    {
        translate([0,0,base_mm]) 
          rpi_zero_bulk(side_wall_mm+4, 0.7); // Inner Hollow For Electronics
        translate([3.5,-50,-0.1])
          cube([100,100,20]);
        translate([-10,-0,-0.1])
          cube([100,50,20]);
    }
      
      
    // Programmer Wire
    translate([5,0,5])
      cube([1,12,2*base_mm+0.4], center=true);
    translate([12,1.5,5])
      cube([15,10,2*base_mm+0.4], center=true);

    // Front Interface
    translate([3,-10,base_mm+pcb_standoff])
      cube([32,10,20]);
    translate([3,-10,base_mm+8])
      cube([53,10,20]);

    // Side Interface
    translate([-5,23/2+1,base_mm+pcb_standoff+10])
      cube([10,12,20], center=true); // Cutout for side usb
    translate([-5,23/2+4,base_mm+pcb_standoff+6+10])
      cube([10,10,20], center=true); // Cutout for SD card on rpizero
     
    // Bendy bit cutout
    translate([4.5,23/2-6,-0.1])
      cube([50,13,10]);

    // Back Programmer Ribbon Cutout
    translate([4,17.5,-0.1])
      cube([1,15,40]);
    translate([9.5,23/2+6.5,-0.1])
        cube([8,20,1.5]);

    // Power Cable
    translate([30-5/2,23/2+6.5,-0.1])
        cube([5,20,base_mm+0.2]);
    translate([4,23/2+6,-0.1])
        cube([15,9,base_mm+pcb_standoff+1]);
    translate([4,23/2+6,3])
        cube([25,9,base_mm+pcb_standoff+1]);
  }
  
  // Bendy bit cutout
  translate([4.5,23/2-5,base_mm-2])
    cube([50,11,2]);
  translate([20,23/2-5,0])
    cube([2,11,base_mm]);
  translate([37,23/2-5,0])
    cube([2,11,base_mm]);
  hull()
  {
    translate([55,23/2-5,0])
        cube([1,11,base_mm]);
    translate([50,23/2-5,base_mm-2])
        cube([1,11,2]);
  }
  
  
  // PCB Clip
  translate([60+4.5,23/2,base_mm+pcb_standoff+pcb_h+1.5])
    rotate([90,0,0])
    cylinder(r=1.5, h=20, center= true);
  
  translate([52,23+4.5,base_mm+pcb_standoff+pcb_h+1.5])
    rotate([0,90,0])
    cylinder(r=1.5, h=15, center= true);
  
  translate([52,-4,base_mm+pcb_standoff+pcb_h+1.5])
    rotate([0,90,0])
    cylinder(r=1.5, h=15, center= true);
  
  //%translate([0,0,base_mm+pcb_standoff]) rpi_zero_bulk(pcb_h, 0); // programmer
  //%translate([0,0,base_mm+pcb_standoff+7]) rpi_zero_bulk(pcb_h, 0); // rpizero
}


rpi_zero_hat_case();
