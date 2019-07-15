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
ledd= 1.6;

/* INSET */
led_mount_inset = 10;
led_mount_angle = 70;

module led_mount(rotation, w, d, h)
{
  rotate([rotation,0,0])
    union()
    {
      translate([ledpcbw/2 - w/2, -d/2, -h])
        cube([w,d,h+5]);
    }
}

difference()
{
  union()
  { 
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
      translate([0,1+led_mount_inset,diffuser_top_h+diffuser_bottom_h])
        led_mount(led_mount_angle,ledw+1,ledd+1,ledh+1);
      translate([0,diffuserh-led_mount_inset,diffuser_top_h+diffuser_bottom_h])
        led_mount(-led_mount_angle,ledw+1,ledd+1,ledh+1);

      // Camera Hole
      translate([ledpcbw/2,ledpcbh/2,-thickness/2])
        cylinder(thickness*3,d=holedia);

      // Camera Hole Bottom Lip
      translate([ledpcbw/2,ledpcbh/2, diffuser_top_h+diffuser_bottom_h-3+0.001])
        cylinder(3, d1=holedia, d2=holedia*1.3);
      
      // Bottom Diffuser
      bottom_flat_width = ledw-1;
      hull()
      {
        translate([(diffuserw - enclosurew)/2,2,-1])
          cube([enclosurew,diffuserh-4,diffuser_top_h]);
        translate([ledpcbw/2 - bottom_flat_width,2,diffuser_top_h-2])
          cube([bottom_flat_width*2, diffuserh-4, diffuser_bottom_h]);
      }
    }
  }
  
  /* Trimming */
  translate([0,0,-thickness])
    cube([diffuserw,1,thickness*4]);
}