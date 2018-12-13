/* Diffuser Lense For A Particular Project (OpenSCAD) */
tol = 0.1;

/* LED PCB */
ledpcbw = 26.7;
ledpcbh = 71.88;
ledpcb_thickness = 3.47;
ledpcb_header_pos = 25;
ledpcb_header_w = 9;
holedia = 16;
orginal_diffuser_h=ledpcb_thickness - 1.59 - tol;
print(orginal_diffuser_h);

/* SMD LED */
ledh = 2.76-1.59;
ledw = 5;


/* Mask spec */
thickness = 0.4;
standoff = 1.5;
holediffuser = holedia+2;

/* Camera Chamber */
camchamberw_org = 27;
camchamberh_org = 70;

camchamberw = camchamberw_org - tol;
camchamberh = camchamberh_org - tol -1;



/* Enclosure hole */
enclosurew = 19;


/* LED MASK */
//rotate([0,180,0])
translate([0,tol,0])
difference()
{ union()
  {
    // Border
    linear_extrude(height = thickness) 
    {
       difference() 
      {
         offset(r = 0) 
          square(size = [camchamberw,camchamberh], center = false);
         offset(r = -2) 
          square(size = [camchamberw,camchamberh], center = false);
       }
    }

    // CAM SUPPORT
    translate([camchamberw/2,camchamberh/2,0])
      cylinder(thickness,d=holediffuser+3);
    translate([0,camchamberh/2 -1,0])
      cube([camchamberw,2,thickness]);
    
    // CAM MASK
    translate([camchamberw/2,camchamberh/2,-orginal_diffuser_h])
      cylinder(orginal_diffuser_h,d=holediffuser+0.5);
    
    // LED MASK AREA
    translate([ledpcbw/2 - ledw/2,0,0])
      cube([ledw,camchamberh,thickness]);
  }

  translate([camchamberw/2,camchamberh/2,-4])
    cylinder(8,d=holediffuser);
}


/* Camera Frame Model */
%translate([-tol/2,-tol/2,-2])
union()
{
  translate([ledpcbw/2 - ledw/2,0,0])
    cube([ledw,camchamberh_org,ledh]);
  
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

