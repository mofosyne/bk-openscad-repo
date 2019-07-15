/* Diffuser Lense For A Particular Project (OpenSCAD) */
tol = 0.5;

/* Camera Chamber */
camchamberw = 27 - tol;
camchamberh = 70 - tol;

/* LED PCB */
holedia = 16 + 2;
thickness=5;

/* Enclosure hole */
enclosurew = 19;

union()
{
  linear_extrude(height = thickness) {
     difference() 
    {
       offset(r = 0) 
       {
        square(size = [camchamberw,camchamberh], center = false);
       }
       offset(r = -1) 
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
}

