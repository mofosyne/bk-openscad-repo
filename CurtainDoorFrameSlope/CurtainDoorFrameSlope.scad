/*
    Curtain Door Frame Slope
    Brian Khuu 2019
    
    Curtian keeps getting caught on part of a doorframe. A slope fixes it.

    https://www.reddit.com/r/functionalprint/comments/c22mtk/curtian_keeps_getting_caught_on_part_of_a/
*/

$fn=100;
w=40;
d=25;
h=60;
dia=8.5;

rotate([0,-90,0])
intersection()
{
  translate([0,-1000/2,-1000/2])
      cube([1000,1000,1000]);

  union()
  {
    difference()
    {
      union()
      {
        translate([dia/2,0,-20])
          cylinder(d=dia, h=20);
        translate([dia/2,0,-20])
          sphere(d=dia+1);
      }
      cube([100,1.5,100], center=true);
    }

    hull()
    {
      translate([0,0,0]) cube([0.01,w,0.01], center=true);
      translate([d,0,0]) cube([0.01,w,0.01], center=true);
      translate([5,0,d]) cube([0.01,w,0.01], center=true);
      translate([0,0,d]) cube([0.01,w,0.01], center=true);
    }

    hull()
    {
      translate([0,0,d]) cube([0.01,w,0.01], center=true);
      translate([5,0,d]) cube([0.01,w,0.01], center=true);
      translate([0,0,h]) cube([0.01,10,0.01], center=true);
    }
  }
}