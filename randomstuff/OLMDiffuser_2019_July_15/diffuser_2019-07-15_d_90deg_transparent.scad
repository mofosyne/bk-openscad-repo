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
led_mount_angle = 180-60;
led_mount_tol=2;
led_mount_thickness=3;

module led_mount(rotation, w, d, h, flipthis)
{
  if (flipthis)
  {
    translate([0, 2, 0.5])
    hull()
    {
      translate([ledpcbw/2, d-2, h-3])
        cube([w,0.1,h+2], center=true);
      translate([ledpcbw/2, -d, 0])
        cube([w,0.1,1], center=true);
    }
  }
  else
  {
    translate([0, 0, 0.5])
    hull()
    {
      translate([ledpcbw/2, -d, h-3])
        cube([w,0.1,h+2], center=true);
      translate([ledpcbw/2, d-2, 0])
        cube([w,0.1,1], center=true);
    }
  }
  rotate([rotation,0,0])
    union()
    {
      translate([ledpcbw/2 - w/2, -d/2, -h])
        cube([w,d,h+4]);
    }
}


module led_mount_pit(rotation, w, d, h, flipthis)
{
  higher=1;
  further=2;
  if (flipthis)
  {
    translate([0, 2, 0.5])
    hull()
    {
      translate([ledpcbw/2, d-2+further, h-3+higher/2])
        cube([w,0.1,h+3+higher], center=true);
      translate([ledpcbw/2, -d, +higher/2])
        cube([w,0.1,1+higher/2], center=true);
    }
    
    rotate([rotation-20,0,0])
      union()
      {
        difference()
        {
          translate([ledpcbw/2-1, -d/2, -h])
            cube([2,d,h+10]);
        }
      }
  }
  else
  {
    translate([0, 0, 0.5])
    hull()
    {
      translate([ledpcbw/2, -d-further, h-3+higher/2])
        cube([w,0.1,h+3+higher], center=true);
      translate([ledpcbw/2, d-2, +higher/2])
        cube([w,0.1,1], center=true);
    }
    
    rotate([rotation+20,0,0])
      union()
      {
        difference()
        {
          translate([ledpcbw/2-1, -d/2, -h])
            cube([2,d,h+10]);
        }
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
          led_mount(led_mount_angle,ledw+led_mount_tol*4+led_mount_thickness,ledd+led_mount_tol+led_mount_thickness,ledh+led_mount_thickness+2, true);
        translate([0,diffuserh-led_mount_inset,0])
          led_mount(-led_mount_angle,ledw+led_mount_tol*4+led_mount_thickness,ledd+led_mount_tol+led_mount_thickness,ledh+led_mount_thickness+2, false);
      }

      // LED Holes
      if(0)
      union()
      {
        translate([0,1+led_mount_inset,0])
          led_mount(led_mount_angle,ledw+led_mount_tol*4,ledd+led_mount_tol,ledh+2, true);
        translate([0,diffuserh-led_mount_inset,0])
          led_mount(-led_mount_angle,ledw+led_mount_tol*4,ledd+led_mount_tol,ledh+2, false);
      }
      
     if(1)
     {
     // LED Pit
      translate([0,1+led_mount_inset,0])
        led_mount_pit(led_mount_angle,ledw+led_mount_tol*4,ledd+led_mount_tol,ledh+2, true);
      translate([0,diffuserh-led_mount_inset,0])
        led_mount_pit(-led_mount_angle,ledw+led_mount_tol*4,ledd+led_mount_tol,ledh+2, false);
     }

      // Camera Hole
      translate([ledpcbw/2,ledpcbh/2,-thickness/2])
        cylinder(thickness*3,d=holedia);

      // Camera Hole Bottom Lip
      translate([ledpcbw/2,ledpcbh/2, diffuser_top_h+diffuser_bottom_h-3+0.001])
        cylinder(3, d1=holedia, d2=holedia*1.3);
     }
     

     
  }
  
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