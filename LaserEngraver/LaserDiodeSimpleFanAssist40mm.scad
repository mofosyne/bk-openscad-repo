// Laser Diode Simple Fan Assist (40mm Fan) (40mm Diode)
// By Brian Khuu December 17, 2020
// This is a 40mm fan mount for a laser diode 40mm
/*
  This is a Remix Of https://www.thingiverse.com/thing:540716
   - "Configurable 40mm fan duct / mount for Wade's extruder" 
     by AndrewBCN November 12, 2014
*/
$fn=32;

/* [Fan] */
// Fan Size
fan_size = 40;
// Fan Mount Base Thickness
fan_mount_base_thickness = 4;
// Fan Mount Screw Pitch
fan_mount_hole_pitch = 32;
// Fan Mount Screw Hole Diameter
fan_mount_hole_diam = 3.1; // [2.6:M2.5, 3.1:M3, 3.6:M3.5, 4.1:M4]
// Fan Mount Nut Diameter
fan_mount_nut_diam = 6.9;
// Fan Mount Nut Depth
fan_mount_nut_depth = 1.5;
// Fan Upper Standoff
fan_upper_standoff = 5;
// Fan Side Standoff
fan_side_standoff = 3;
// Fan Mount Corner Radius
fan_mount_corner_r = 1;

/* [Laser Diode] */
// Laser Diode Size
laserDiode_size = 40;
// Laser Diode Thickness
laserDiode_thickness = 5;
// Laser Diode Mount Screw Pitch
laserDiode_screw_pitch = 32;
// Laser Diode Hole Diameter (3.1mm typical but increased to 3.5mm to fix)
laserDiode_hole_diam = 3.5; // [2.6:M2.5, 3.1:M3, 3.6:M3.5, 4.1:M4]
// Laser Diode Lens Diameter
laserDiode_lens_dia = 15;
// Laser Diode Corner Radius
laserDiode_corner_r = 1;

module fanMount() 
{
  // the base - should fit exactly to a 40mm fan with 32mm hole spacing
  // build a square base for the fan, 4mm thick with rounded
  // corners, and make a round hole in it that matches the fan
  
  /* Define some points beforehand */

  // Base Corner
  P1=[-fan_size/4-fan_mount_corner_r + fan_upper_standoff,fan_size/2-fan_mount_corner_r,fan_mount_base_thickness/2];
  P2=[-fan_size/2+fan_mount_corner_r,fan_size/2-fan_mount_corner_r,fan_mount_base_thickness/2];
  P3=[-fan_size/4-fan_mount_corner_r + fan_upper_standoff,-fan_size/2+fan_mount_corner_r,fan_mount_base_thickness/2];
  P4=[-fan_size/2+fan_mount_corner_r,-fan_size/2+fan_mount_corner_r,fan_mount_base_thickness/2];

  // Screw Holes
  P6=[-fan_mount_hole_pitch/2 + fan_upper_standoff,fan_mount_hole_pitch/2,fan_mount_base_thickness/2];
  P8=[-fan_mount_hole_pitch/2 + fan_upper_standoff,-fan_mount_hole_pitch/2,fan_mount_base_thickness/2];

  // Hex Holes
  P10=[-fan_mount_hole_pitch/2 + fan_upper_standoff,fan_mount_hole_pitch/2,fan_mount_base_thickness/2+fan_mount_nut_depth];
  P12=[-fan_mount_hole_pitch/2 + fan_upper_standoff,-fan_mount_hole_pitch/2,fan_mount_base_thickness/2+fan_mount_nut_depth];

  // Fan Hole Standoff
  P13=[fan_upper_standoff, 0, 0];

  // Standoff
  translate([fan_size/2,0,0])
  hull() 
  {
    // Base Corners
    PP1=[fan_side_standoff,laserDiode_size/2-fan_mount_corner_r,laserDiode_thickness/2];
    PP2=[-1,laserDiode_size/2-fan_mount_corner_r,laserDiode_thickness/2];
    PP3=[fan_side_standoff,-laserDiode_size/2+fan_mount_corner_r,laserDiode_thickness/2];
    PP4=[-1,-laserDiode_size/2+fan_mount_corner_r,laserDiode_thickness/2];

    translate(PP1) cylinder(r=fan_mount_corner_r, h=laserDiode_thickness, center=true);
    translate(PP2) cylinder(r=fan_mount_corner_r, h=laserDiode_thickness, center=true);
    translate(PP3) cylinder(r=fan_mount_corner_r, h=laserDiode_thickness, center=true);
    translate(PP4) cylinder(r=fan_mount_corner_r, h=laserDiode_thickness, center=true);
  }

  // Fan Mount
  translate([fan_size/2+fan_side_standoff,0,0])
  rotate([0,-45,0])
  translate([fan_size/2,0,0])
  difference() 
  {
    union() 
    {
      hull() 
      {
        translate(P1) cylinder(r=fan_mount_corner_r, h=fan_mount_base_thickness, center=true);
        translate(P2) cylinder(r=fan_mount_corner_r, h=fan_mount_base_thickness, center=true);
        translate(P3) cylinder(r=fan_mount_corner_r, h=fan_mount_base_thickness, center=true);
        translate(P4) cylinder(r=fan_mount_corner_r, h=fan_mount_base_thickness, center=true);
      }
    }

    // Screw Holes
    translate(P6) cylinder(r=fan_mount_hole_diam/2, h=fan_mount_base_thickness+0.5, center=true);
    translate(P8) cylinder(r=fan_mount_hole_diam/2, h=fan_mount_base_thickness+0.5, center=true);
    
    // Hex Holes
    hull()
    {
        translate(P10) cylinder(r=fan_mount_nut_diam/2, h=fan_mount_base_thickness, center=true, $fn=6);
        translate([fan_size/4,0,0])
            translate(P10) cylinder(r=fan_mount_nut_diam/2, h=fan_mount_base_thickness, center=true, $fn=6);
    }
     
    hull()
    {
        translate(P12) cylinder(r=fan_mount_nut_diam/2, h=fan_mount_base_thickness, center=true, $fn=6);
        translate([fan_size/2,0,0])
            translate(P12) cylinder(r=fan_mount_nut_diam/2, h=fan_mount_base_thickness, center=true, $fn=6);        
    }
    
    translate(P13)
      cylinder(r=37/2, h=11, center=true, $fn=64);
  }
}

module laserDiodeMountBase()
{ 
  /* Define some points beforehand */

  // Base Corners
  P1=[laserDiode_size/2-laserDiode_corner_r,laserDiode_size/2-laserDiode_corner_r,laserDiode_thickness/2];
  P2=[-laserDiode_size/2+laserDiode_corner_r,laserDiode_size/2-laserDiode_corner_r,laserDiode_thickness/2];
  P3=[laserDiode_size/2-laserDiode_corner_r,-laserDiode_size/2+laserDiode_corner_r,laserDiode_thickness/2];
  P4=[-laserDiode_size/2+laserDiode_corner_r,-laserDiode_size/2+laserDiode_corner_r,laserDiode_thickness/2];

  // Screw Holes
  P5=[laserDiode_screw_pitch/2,laserDiode_screw_pitch/2,laserDiode_thickness/2];
  P6=[-laserDiode_screw_pitch/2,laserDiode_screw_pitch/2,laserDiode_thickness/2];
  P7=[laserDiode_screw_pitch/2,-laserDiode_screw_pitch/2,laserDiode_thickness/2];
  P8=[-laserDiode_screw_pitch/2,-laserDiode_screw_pitch/2,laserDiode_thickness/2];

  difference() 
  {
    union() 
    {        
      // fanMount
      rotate([0,0,-90]) fanMount();
      rotate([0,0,+90]) fanMount();
      rotate([0,0,180]) fanMount();
        
      // Bulk
      hull() 
      {
        translate(P1) cylinder(r=laserDiode_corner_r, h=laserDiode_thickness, center=true);
        translate(P2) cylinder(r=laserDiode_corner_r, h=laserDiode_thickness, center=true);
        translate(P3) cylinder(r=laserDiode_corner_r, h=laserDiode_thickness, center=true);
        translate(P4) cylinder(r=laserDiode_corner_r, h=laserDiode_thickness, center=true);
      }
    }
    
    // screw holes
    translate(P5) cylinder(r=laserDiode_hole_diam/2, h=laserDiode_thickness+0.5, center=true);
    translate(P6) cylinder(r=laserDiode_hole_diam/2, h=laserDiode_thickness+0.5, center=true);
    translate(P7) cylinder(r=laserDiode_hole_diam/2, h=laserDiode_thickness+0.5, center=true);
    translate(P8) cylinder(r=laserDiode_hole_diam/2, h=laserDiode_thickness+0.5, center=true);
    
    // laser holes
    hull()
    {
        translate([0,0,laserDiode_thickness])
            cylinder(r=laserDiode_size/2-2, h=0.1, center=true, $fn=64);  
        cylinder(r=laserDiode_lens_dia, h=0.1, center=true, $fn=64);
    }
  }
}

laserDiodeMountBase();
