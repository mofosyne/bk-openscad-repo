/*
Alignment Pin Soldering Jig for OTS G2
Author: Brian Khuu (2019)

1mm matrix pins

x, y holes position
3.302, 5.4864
2.5908, 52.8828
27.5336, 54.7624
27.2288, 5.4864

*/
$fn=20;

tol=0.6;
thickness=0.5;
shiftup=0.5;

pinstandoff=5; // Actually 6
pindia=1+tol;
pindiaouter=3;

difference()
{
  union()
  {
    cube([35, 60, thickness]);
    translate([1,   0,  0])
    union()
    {
    translate([3.302,   5.4864,  shiftup]) cylinder(r1=pindiaouter, r2=pindiaouter/2, pinstandoff);
    translate([2.5908,  52.8828, shiftup]) cylinder(r1=pindiaouter, r2=pindiaouter/2, pinstandoff);
    translate([27.5336, 54.7624, shiftup]) cylinder(r1=pindiaouter, r2=pindiaouter/2, pinstandoff);
    translate([27.2288, 5.4864,  shiftup]) cylinder(r1=pindiaouter, r2=pindiaouter/2, pinstandoff);
    }
    
    translate([30/2,0,0])
    union()
    {
      cube([4, 100, thickness]);
      translate([2,   100,  0]) cylinder(r1=2, r2=1, shiftup+pinstandoff);
      translate([2,   90,  0]) cylinder(r1=2, r2=1, shiftup+pinstandoff);
    }
  }

    translate([1,   0,  0])
    union()
    {
  translate([3.302,   5.4864,  shiftup]) cylinder(r=pindia/2, thickness+100);
  translate([2.5908,  52.8828, shiftup]) cylinder(r=pindia/2, thickness+100);
  translate([27.5336, 54.7624, shiftup]) cylinder(r=pindia/2, thickness+100);
  translate([27.2288, 5.4864,  shiftup]) cylinder(r=pindia/2, thickness+100);
  
  // Sit
  translate([3.302,   5.4864,  pinstandoff-1]) cylinder(r1=pindia/2, r2=pindia/2 +0.2, 2);
  translate([2.5908,  52.8828, pinstandoff-1]) cylinder(r1=pindia/2, r2=pindia/2 +0.2, 2);
  translate([27.5336, 54.7624, pinstandoff-1]) cylinder(r1=pindia/2, r2=pindia/2 +0.2, 2);
  translate([27.2288, 5.4864,  pinstandoff-1]) cylinder(r1=pindia/2, r2=pindia/2 +0.2, 2);
    }
}