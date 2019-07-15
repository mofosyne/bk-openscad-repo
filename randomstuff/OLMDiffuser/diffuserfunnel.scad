$fn=30;

/* Diffuser Lense For A Particular Project (OpenSCAD) */
tol = 0.1;

/* LED PCB */
holedia   = 16;

/* Diffuser spec */
dheight = 10;
thickness = 1.5;
standoff = 1.5;
holediffuser = holedia+4;

/* Camera Chamber */
camchamberw_org = 27;
camchamberh_org = 70;

camchamberw = camchamberw_org - tol;
camchamberh = camchamberh_org - tol -1;



/* Enclosure hole */
enclosurew = 19;

/* Diffuser */
union()
{
  // Box
  linear_extrude(height = dheight) 
  {
     difference() 
    {
       offset(r = 0) 
        square(size = [camchamberw,camchamberh], center = false);
       offset(r = -0.5) 
        square(size = [camchamberw,camchamberh], center = false);
     }
  }
  
  // Funnel
  difference()
  {
    translate([camchamberw_org/2,camchamberh_org/2,0])
    difference()
    {
      linear_extrude(height = dheight, scale=4) 
        circle(d=holediffuser);
      linear_extrude(height = dheight+1, scale=4) 
        circle(d=holediffuser-2);
    }
    linear_extrude(height = 10) 
    {
      difference() 
      {
         offset(r = 100) 
          square(size = [camchamberw,camchamberh], center = false);
         offset(r = 0) 
          square(size = [camchamberw,camchamberh], center = false);
       }
    }
  }
  
  // Base
  linear_extrude(height = 0.1) 
  {
    difference() 
    {
      square(size = [camchamberw,camchamberh], center = false);
      translate([camchamberw/2,camchamberh/2,0])
        circle(d=holediffuser);
    }
  }
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
