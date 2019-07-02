$fn=100;

/*
  Robot Vac Skirt Extender
  For Model: Hoover Performer Plus
  Author: Brian Khuu 2019
*/

// Hole Dia
hole_dia=4.6;

// Hole Spacing
hole_spacing=28.5-4.6;

// Skirt Length from lower hole
skirt_length=35;

// Thickness
thickness=4;

// Skirt Thickness
thickness_skirt=3;

// Width
width=hole_dia*5;

// radius of bot
bot_radius=160;

// Bottom Skirt Height
bot_skirt_h=15;

module minimum_skirt()
{
  translate([skirt_length,0,0])
  difference()
  {
    union()
    {
      hull()
      {
        translate([0,0,0])
          cylinder(d=width, h=thickness, $fn=40, center=true);
        translate([hole_spacing,0,0])
          cylinder(d=width, h=thickness, $fn=40, center=true);
        translate([-skirt_length,0,0])
          cube([0.001,width,thickness], center=true);
        // Rounded Bottom
        //translate([-skirt_length,0,0])
        //  rotate([90,0,0])
        //    cylinder(d=thickness, h=width, $fn=40, center=true);
      }
    }
    translate([0,0,0])
      cylinder(d=hole_dia, h=2+thickness, $fn=40, center=true);
    translate([hole_spacing,0,0])
      cylinder(d=hole_dia, h=2+thickness, $fn=40, center=true);
  }
}

module full_skirt()
{
  difference()
  //
  translate([bot_radius,0,0])
  rotate([0,-90,0])
  minimum_skirt();
  
  //
  rotate([0,0,-45])
  rotate_extrude(angle=90)
  translate([bot_radius,bot_skirt_h/2,0])
    square([thickness_skirt,bot_skirt_h], center=true);
}

full_skirt();