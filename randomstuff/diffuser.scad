/* Diffuser Lense For A Particular Project (OpenSCAD) */
tol = 0.8;

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
ledh = 2.76-1.59;
ledw = 3.5;

// Use if not printing with raft
//cube([ledpcb_header_w,ledpcb_header_pos, 0.1]);

difference()
{
  union()
  {
    cube([diffuserw,diffuserh,thickness]);
    hull()
    {
      translate([(diffuserw - enclosurew)/2,0,0])
        cube([enclosurew,diffuserh,thickness]);
      translate([ledpcbw/2 - ledw,0,thickness])
        cube([ledw*2,diffuserh,ledh]);
    }
  }
  
  translate([ledpcbw/2 - ledw/2,0,0])
    cube([ledw,ledpcbh,ledh]);

  translate([ledpcbw/2,ledpcbh/2,-thickness/2])
    cylinder(thickness*3,d=holedia);

  translate([0,0,-thickness/2])
    cube([ledpcb_header_w,ledpcb_header_pos,thickness*3]);
}