$fn=40;

/* Diffuser Lense For A Particular Project (OpenSCAD) */

/* Camera */
cam_dia = 10.5;


/* LED PCB */
ledpcbw = 26.7;
ledpcbh = 71.88;
ledpcb_thickness = 3.47;
ledpcb_header_pos = 25;
ledpcb_header_w = 9;
holedia = cam_dia + 1;

/* Diffuser */
diffuserw=ledpcbw;
diffuserh=ledpcbh-1.82;
thickness=ledpcb_thickness-1.59;

/* Top Diffuser */
diffuser_top_h=0.5;

/* Bottom Diffuser */
diffuser_bottom_h=ledpcb_thickness;

/* Enclosure hole */
enclosurew = ledpcb_header_pos-2;

/* SMD LED */
ledh = 2.76-1.59;
ledw = 4;

difference()
{
  union()
  {
    // Cutout area to allow for raftless printing
    cube([ledpcb_header_w,ledpcb_header_pos, 0.1]);
    
    // Main object
    difference()
    {
      union()
      { // Main Body
        
        // Top Diffuser
        cube([diffuserw,diffuserh,diffuser_top_h]);
        
        // Bottom Diffuser
        bottom_flat_width = ledw;
        hull()
        {
          translate([(diffuserw - enclosurew)/2,0,0])
            cube([enclosurew,diffuserh,diffuser_top_h]);
          translate([ledpcbw/2 - bottom_flat_width,0,diffuser_top_h])
            cube([bottom_flat_width*2, diffuserh, diffuser_bottom_h]);
        }
      }

      // LED Holes
      translate([ledpcbw/2 - ledw/2, 0, diffuser_top_h+diffuser_bottom_h-ledh])
        cube([ledw,ledpcbh,ledh]);

      // Camera Hole
      translate([ledpcbw/2,ledpcbh/2,-thickness/2])
        cylinder(thickness*3,d=holedia);

      // Camera Hole Top Lip
      //translate([ledpcbw/2,ledpcbh/2,0])
      //  cylinder(2, d1=holedia*1.5, d2=holedia);

      // Camera Hole Bottom Lip
      translate([ledpcbw/2,ledpcbh/2, diffuser_top_h+diffuser_bottom_h-3])
        cylinder(3, d1=holedia, d2=holedia*1.3);

      // Header Hole
      header_height=1.5;
      translate([ledpcbw-ledpcb_header_w, ledpcb_header_pos-13, diffuser_top_h+diffuser_bottom_h-header_height])
        cube([ledpcb_header_w,13,header_height]);
      
    }
  }
  
  /* Trimming */
  translate([0,0,-thickness])
    cube([diffuserw,1,thickness*4]);
}