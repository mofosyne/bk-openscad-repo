/* Diffuser Lense For A Particular Project (OpenSCAD) */
tol = 0.1;

/* LED PCB */
holedia   = 16;

/* Diffuser spec */
thickness = 1.5;
standoff = 1.5;
holediffuser = holedia+7;

/* Camera Chamber */
camchamberw_org = 27;
camchamberh_org = 70;

camchamberw = camchamberw_org - tol;
camchamberh = camchamberh_org - tol -1;



/* Enclosure hole */
enclosurew = 19;

rotate([0,180])
{

/* Diffuser */
translate([0, 1/2, 0])
difference()
{
  union()
  {

    // Diffuser Body
    translate([0, 0, standoff])
    {
      hull()
      {
        translate([0, 0, 0])
          cube([camchamberw,camchamberh,0.1], center = false);
        translate([-0.6/2, 0, thickness])
          cube([camchamberw+0.6,camchamberh,0.1], center = false);
      }
    }
    
    // Standoff
    linear_extrude(height = standoff) 
    {
       difference() 
      {
         offset(r = 0) 
          square(size = [camchamberw,camchamberh], center = false);
         offset(r = -2) 
          square(size = [camchamberw,camchamberh], center = false);
         translate([camchamberw/2, camchamberh/2, 0])
          square(size = [camchamberw,camchamberh*5/6], center = true);
        }
    }
    
    translate([camchamberw/2,camchamberh/2,])
      cylinder(standoff,d=holediffuser+4);
  }
  translate([camchamberw/2,camchamberh/2,-thickness/2])
    cylinder((standoff+thickness)*2,d=holediffuser);
}

/* Camera Frame Model */
%translate([-tol/2,-tol/2,-2])
union()
{
  %linear_extrude(height = 2) 
  {
     difference() 
    {
       offset(r = 0) 
        square(size = [camchamberw_org,camchamberh_org], center = false);
       offset(r = -2) 
        square(size = [camchamberw_org,camchamberh_org], center = false);
     }
  }
  %translate([camchamberw_org/2,camchamberh_org/2,-thickness/2])
     cylinder(thickness,d=holedia);
}

}
