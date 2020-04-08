/*
    Dishwasher Grid Guard
    By Brian Khuu 2019
    
    Dishwasher detergent kept getting stuck if plates stacked incorrectly. A plastic guard solves this.
    https://www.reddit.com/r/functionalprint/comments/cbtglz/dishwasher_detergent_kept_getting_stuck_if_plates/
*/

$fn=20;

// Thickness
thickness=0.6;

// Wire Diameter
wire_dia=5;

// Wire Tolerance
wire_tol=1;

// Height
h=150;

// Width
w=110;

// Distance from bottom of first wire
c1=60;

// Distance from bottom of second wire
c2=c1+32+wire_dia;

module dishwasher_grid(h, w, thickness, wire_dia, wire_tol, c1, c2)
{
  module clip( wire_dia, baseh )
  {
    rotate([0,-90,90])
    union()
    {
      translate([baseh,0,0])
      difference()
      {
        union()
        {
          cylinder(r=(wire_dia+wire_tol)/2+1, h=wire_dia*2, center=true);
          translate([wire_dia/2,0,0])
            cylinder(r=(wire_dia+wire_tol)/2+1, h=wire_dia*2, center=true);
        }
        translate([wire_dia/2,0,0])
          cylinder(r=(wire_dia+wire_tol)/2, h=20, center=true);
        translate([wire_dia,0,0])
          cube([wire_dia,(wire_dia-1),wire_dia*3],center=true);
        translate([-wire_dia*4,-wire_dia*2,-wire_dia*2])
          cube([wire_dia*4, wire_dia*4, wire_dia*4]);
      }
      translate([baseh/2,0,0])
        rotate([0,90,0])
          cylinder(r=wire_dia, h=baseh, center=true);
    }
  }

  module clip_stick(baseh)
  {
    translate([wire_dia,w*2/3,0])
      clip(wire_dia,baseh);
    translate([wire_dia,w*1/3,0])
      clip(wire_dia,baseh);
  }

  // Frame
  difference()
  {
    cube([h,w,thickness]);
    translate([h/2,w/2,0])
      cube([h-wire_dia*2,w-wire_dia*2,thickness*3],center=true);
  }

  // Hoz Grid
  for(hi=[1:1:3])
  {
    translate([h*hi/4,0,0])
      cube([wire_dia,w,thickness]);
  }

  // Vertical Grid
  translate([0,w*1/3-wire_dia,0])
    cube([h,wire_dia*2,thickness]);
  translate([0,w*2/3-wire_dia,0])
    cube([h,wire_dia*2,thickness]);

  // Clips
  translate([c1,0,0])
    clip_stick(thickness);
  translate([c2,0,0])
    clip_stick(thickness);
}

dishwasher_grid(h, w, thickness, wire_dia, wire_tol, c1, c2);