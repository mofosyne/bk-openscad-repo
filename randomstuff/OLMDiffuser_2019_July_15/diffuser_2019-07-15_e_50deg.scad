$fn=40;

/* Diffuser Lense For A Particular Project (OpenSCAD) */

// NOTE on this near 45deg. The idea is that we want the spot effect to just miss the window

/* Camera */
cam_dia = 10.5;

/* LED PCB */
ledpcbw = 26.7;
ledpcbh = 71.88;
ledpcb_thickness = 3.47;
ledpcb_header_pos = 25;
ledpcb_header_w = 9;
holedia = (cam_dia + 8);

/* Diffuser */
diffuserw=ledpcbw;
diffuserh=ledpcbh-1.82;
thickness=ledpcb_thickness-1.59;

/* Top Diffuser */
diffuser_top_h=0.5;

/* Bottom Diffuser */
diffuser_bottom_h=1;

/* Enclosure hole */
enclosurew = ledpcb_header_pos-2;

/* SMD LED */
ledh = 2.76-1.59;
ledw = 4;
ledd = 1.6;

/* INSET */
led_mount_inset = 5;
led_mount_angle = 180-40;
led_mount_tol=2;
led_mount_thickness=3;

module led_mount(rotation, w, d, h, inset=0)
{
  rotate([rotation,0,0])
    union()
    {
      translate([ledpcbw/2 - w/2, -d/2, -h+inset])
        cube([w,d,h+4+1]);
    }
}


module led_mount_pit(rotation, w, d, h)
{
  translate([0,0,1])
  rotate([rotation+5,0,0])
    union()
    {
      difference()
      {
        translate([ledpcbw/2 - w/2, -d/2, h/2])
          cube([w,d,h+4]);
        translate([ledpcbw/2-1, -d/2+1, -h])
          cube([2,d,h+4]);
      }
    }
}

intersection()
{
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
        
        // LED Holes
        translate([0,1+led_mount_inset,0])
          led_mount(led_mount_angle,ledw+led_mount_tol*4+led_mount_thickness,ledd+led_mount_tol+led_mount_thickness,ledh+led_mount_thickness+0);
        translate([0,diffuserh-led_mount_inset,0])
          led_mount(-led_mount_angle,ledw+led_mount_tol*4+led_mount_thickness,ledd+led_mount_tol+led_mount_thickness,ledh+led_mount_thickness+0);
      }

      // LED Holes
      translate([0,1+led_mount_inset,0])
        led_mount(led_mount_angle,ledw+led_mount_tol*4,ledd+led_mount_tol,ledh+2);
      translate([0,diffuserh-led_mount_inset,0])
        led_mount(-led_mount_angle,ledw+led_mount_tol*4,ledd+led_mount_tol,ledh+2);

      // Camera Hole
      translate([ledpcbw/2,ledpcbh/2,-thickness/2])
        cylinder(thickness*3,d=holedia);

      // Camera Hole Bottom Lip
      translate([ledpcbw/2,ledpcbh/2, diffuser_top_h+diffuser_bottom_h-3+0.001])
        cylinder(3, d1=holedia, d2=holedia*1.3);
     }
     
     if(1)
     {
     // LED Pit
      translate([0,1+led_mount_inset,0])
        led_mount_pit(led_mount_angle,ledw+led_mount_tol*4,ledd+led_mount_tol,ledh+2);
      translate([0,diffuserh-led_mount_inset,0])
        led_mount_pit(-led_mount_angle,ledw+led_mount_tol*4,ledd+led_mount_tol,ledh+2);
     }
     
  }
  
  /* Wire Cut */
  #translate([ledpcbw/2, 0, 0])
    cube([2,30,2], center=true);
  #translate([ledpcbw/2, diffuserh, 0])
    cube([2,30,2], center=true);

  /* Trimming */
  translate([0,0,-thickness])
    cube([diffuserw,1,thickness*4]);
  
  /* Remove bottom */
  translate([0,0,-5])
    cube([1000,1000,10], center=true);  
  
  /* Trimming */
  translate([ledpcbw/2,0,-thickness])
    cylinder(r=2,h=100);
}
  cube([diffuserw,diffuserh,1000]);
}