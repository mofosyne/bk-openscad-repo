$fn=50;

// length of mounting strip base
sx = 15; 
// widith of mounting strip base
sy = 50  ;
// height of mounting strip base
sh = 2  ;

side_wall_lim=90;

module hairdryer_ring_old()
{
  ring_rotate=45;
  openingdeg=50;
  dia=50;
  thickness = 2;
  rotate([ring_rotate,0,0])
  translate([dia+thickness+1,0,0])
  rotate([0,0,openingdeg/2])
  rotate_extrude(angle = 360-openingdeg, convexity = 3)
  translate([dia, 0, 0])
  minkowski()
  {
    square([thickness,thickness]);
    circle(r=1);
  }
}

module hairdryer_ring()
{
  ring_rotate=45;

  translate([0,0,30])
  rotate([ring_rotate,0,0])
  translate([side_wall_lim/2,0,0])
    cylinder(r=side_wall_lim*0.8/2, h=100, center=true);
}





difference()
{
  hull()
  {
    translate([1/2,0,0])
      cube([1,sx,sy], center=true);
    translate([side_wall_lim-1/2,0,0])
      cube([1,sx,sy], center=true);
    translate([side_wall_lim/2,-sx/2-2,-sy/2])  
      cube([side_wall_lim,0.001,0.001], center=true);
    translate([side_wall_lim/2,-sx/2-20,sy/2+10])  
      cube([side_wall_lim,1,1], center=true);

  }
  
  #hairdryer_ring();
  translate([side_wall_lim/2,0,0])
    cube([side_wall_lim-10,sx,sy*2], center=true);
  
  // For adhesive Strip
  translate([1/2,0,0])
    cube([1,sx,sy*2], center=true);
  translate([side_wall_lim-1/2,0,0])
    cube([1,sx,sy*2], center=true);
  
  // Cleanup Edge
  translate([0,0,0])
    cube([1,sx,sy*2], center=true);
  translate([side_wall_lim,0,0])
    cube([1,sx,sy*2], center=true);
}



// Bathroom Walls
%translate([-1/2,0,0])
  cube([1,100,100], center=true);
%translate([side_wall_lim+1/2,0,0])
  cube([1,100,100], center=true);