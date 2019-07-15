/* Diffuser Lense For A Particular Project (OpenSCAD) */
tol = 2;

/* Camera Chamber */
camchamberw = 27 - tol;
camchamberh = 70 - tol;

/* LED PCB */
holedia = 16 + 2;
thickness=3;

/* Enclosure hole */
enclosurew = 19;

/* Shroud */
shroud_mount_inset = 17.5;
shroud_mount_height = -2;
shroud_thickness = 1;
shroud_Length = 20;

/* SMD LED */
ledh = 2.76-1.59;
ledw = 4;
ledd = 1.6;

/* SMD LED INSET */
led_mount_inset = 13;
led_mount_angle = 180+30;
led_mount_tol=2;
led_mount_thickness=1;
led_mount_height = 4;

module led_mount(rotation, w, d, h)
{
  rotate([rotation,0,0])
    union()
    {
      translate([camchamberw/2 - w/2, -d/2, -h])
        cube([w,d,h+4]);
    }
}


module led_shroud(rotation, w, d, h)
{
  rotate([rotation,0,0])
    union()
    {
      translate([camchamberw/2 - w/2, -d/2, -h])
        cube([w,d,h+4]);
    }
}

/* Grippers*/
translate([-5,0,0])
  cube([camchamberw+10,10, 0.2]);
translate([-5,camchamberh-10,0])
  cube([camchamberw+10,10, 0.2]);

intersection()
{
  union()
  {
    linear_extrude(height = thickness) {
       difference() 
      {
         offset(r = 0) 
         {
          square(size = [camchamberw,camchamberh], center = false);
         }
         offset(r = -0.5) 
         {
          square(size = [camchamberw,camchamberh], center = false);
         }
       }
    }
    
    %difference()
    {
      translate([camchamberw/2,camchamberh/2, 0])
        cylinder(thickness,d=holedia+7);
      translate([camchamberw/2,camchamberh/2,-thickness/2])
        cylinder(thickness*2,d=holedia);
    }
   
    // Shroud
    difference()
    {
      union()
      { // Main Body
        translate([0,shroud_mount_height+shroud_mount_inset,shroud_mount_height])
          led_shroud(led_mount_angle,camchamberw,ledd*4+shroud_thickness,shroud_Length);
        translate([0,camchamberh-shroud_mount_inset,shroud_mount_height])
          led_shroud(-led_mount_angle,camchamberw,ledd*4+shroud_thickness,shroud_Length);
      }

      translate([0,shroud_mount_height+shroud_mount_inset,shroud_mount_height])
        led_mount(led_mount_angle,camchamberw-shroud_thickness,ledd*4,shroud_Length+1);
      translate([0,camchamberh-shroud_mount_inset,shroud_mount_height])
        led_mount(-led_mount_angle,camchamberw-shroud_thickness,ledd*4,shroud_Length+1);
      
      //translate([0,0,-1])
      //  cube([camchamberw,camchamberh, thickness]);
     }
    
    // led Holder
    difference()
    {
      union()
      { // Main Body
        // LED Holes
        translate([0,led_mount_inset,led_mount_height])
          led_mount(led_mount_angle,camchamberw,ledd*2+led_mount_tol+led_mount_thickness,ledh);
        translate([0,camchamberh-led_mount_inset,led_mount_height])
          led_mount(-led_mount_angle,camchamberw,ledd*2+led_mount_tol+led_mount_thickness,ledh);
      }

      // LED Holes
      translate([0,led_mount_inset,led_mount_height])
        led_mount(led_mount_angle,ledw+led_mount_tol*2,ledd+led_mount_tol,ledh+2);
      translate([0,camchamberh-led_mount_inset,led_mount_height])
        led_mount(-led_mount_angle,ledw+led_mount_tol*2,ledd+led_mount_tol,ledh+2);
     }
  }

  /* Remove bottom */
  cube([camchamberw,camchamberh, 1000]);
}