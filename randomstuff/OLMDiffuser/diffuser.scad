/* Diffuser Lense For A Particular Project (OpenSCAD) */
tol = 0.5;

/* LED PCB */
ledpcbw = 26.7;
ledpcbh = 71.88;
ledpcb_thickness = 3.47;
ledpcb_header_pos = 25;
ledpcb_header_w = 9;
holedia = 16 + 2;

/* Diffuser */
diffuserw=ledpcbw;
diffuserh=ledpcbh-1.82;
thickness=ledpcb_thickness-1.59 - tol;

/* Enclosure hole */
enclosurew = 19;

/* SMD LED */
ledh = 2.76-1.59 + tol;
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
        cube([diffuserw,diffuserh,thickness]);
        hull()
        {
          translate([(diffuserw - enclosurew)/2,0,0])
            cube([enclosurew,diffuserh,thickness]);
          translate([ledpcbw/2 - ledw,0,ledh])
            cube([ledw*2,diffuserh,ledh]);
        }
      }

      // LED Holes
      translate([ledpcbw/2 - ledw/2,0,0])
        cube([ledw,ledpcbh,ledh]);

      // Camera Hole
      translate([ledpcbw/2,ledpcbh/2,-thickness/2])
        cylinder(thickness*3,d=holedia);

      // Header Hole
      translate([0,0,-thickness/2])
        cube([ledpcb_header_w,ledpcb_header_pos,thickness*3]);
    }
  }
  
  /* Trimming */
  translate([0,0,-thickness])
    cube([diffuserw,1,thickness*4]);
}