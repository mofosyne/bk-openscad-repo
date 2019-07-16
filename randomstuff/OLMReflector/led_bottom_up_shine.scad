/* Diffuser Lense For A Particular Project (OpenSCAD) */
tol = 2;

/* Camera Chamber */
camchamberw = 27 - tol;
camchamberh = 70 - tol;

/* LED PCB */
holedia = 16 + 2;
thickness=15;

/* Enclosure hole */
enclosurew = 19;


/* SMD LED */
ledh = 0;
ledw = 4;
ledd = 1.6;

/* SMD LED INSET */
led_mount_inset = 6;
led_mount_angle = -10;
led_mount_tol=1;
led_mount_thickness=1;
led_mount_height = 4;

module led_mount(rotation, w, d, h, offset)
{
  rotate([rotation,0,0])
    union()
    {
      translate([camchamberw/2 - w/2, -d/2, offset])
        cube([w,d,h+4]);
    }
}

module led_mount_wire_slot(rotation, w, d, h, offset)
{
  rotate([rotation,0,0])
    union()
    {
      translate([camchamberw/2 - w/2, -d, offset])
        cube([w,d,h+4]);
      translate([camchamberw/2 - w/2, -d, offset])
        cube([w,d,h+4]);
    }
}
module led_mount_wire_slot_opposite(rotation, w, d, h, offset)
{
  rotate([rotation,0,0])
    union()
    {
      translate([camchamberw/2 - w/2, 0, offset])
        cube([w,d,h+4]);
    }
}

/* Grippers*/
translate([-5,led_mount_inset-4,0])
  cube([camchamberw+10,10, 0.2]);
translate([-5,camchamberh-(led_mount_inset+4),0])
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
   
    
    // led Holder
    difference()
    {
      union()
      { // Main Body
        // LED Holes
        translate([0,led_mount_inset,led_mount_height])
          led_mount(led_mount_angle,camchamberw,ledd+led_mount_tol+led_mount_thickness,ledh,0);
        translate([0,camchamberh-led_mount_inset,led_mount_height])
          led_mount(-led_mount_angle,camchamberw,ledd+led_mount_tol+led_mount_thickness,ledh,0);
      }

      // LED Holes
      translate([0,led_mount_inset,led_mount_height])
        led_mount(led_mount_angle,ledw+led_mount_tol,ledd+led_mount_tol,ledh, 1);
      translate([0,camchamberh-led_mount_inset,led_mount_height])
        led_mount(-led_mount_angle,ledw+led_mount_tol,ledd+led_mount_tol,ledh, 1);
      
      // LED Wire
      translate([0,led_mount_inset,led_mount_height])
        led_mount_wire_slot_opposite(led_mount_angle,1,ledd+led_mount_tol,ledh, 1);
      translate([0,camchamberh-led_mount_inset,led_mount_height])
        led_mount_wire_slot(-led_mount_angle,1,ledd+led_mount_tol,ledh, 1);
     }
  
    // Base
    difference()
    {
      empty_space = camchamberh*2/3;
      cube([camchamberw,camchamberh, 1]);
      translate([0,camchamberh/2-empty_space/2,-2], center=true)
        cube([camchamberw,empty_space, 4]);  
    }
  }

  /* Remove bottom */
  cube([camchamberw,camchamberh, 1000]);
}