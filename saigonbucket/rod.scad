$fn=40;

rotate([90,0,0])
difference()
{
  union()
  {
    cylinder(100,r=2);
    hull()
    {    
      translate([0,0,0])  sphere(r=2,center=true);
      translate([0,1,0])  sphere(r=2,center=true);
    }
    hull()
    {
      translate([0,0,100]) sphere(r=2,center=true);    
      translate([0,1,100]) sphere(r=2,center=true);
    }
  }

  #translate([0,2,1.5]) rotate([90,0,90])cylinder(10,r=0.5,center=true);
  #translate([0,2,100-1.5]) rotate([90,0,90])cylinder(10,r=0.5,center=true);
  #translate([-5,-3,-5]) cube([10,2,110]);
}