$fn=50;
// Saigon style fruit bucket

module bucketshape(size)
{
    difference(){
    sphere(r=size/2);
    translate([-size/2,-size/2,0]) cube([size,size,size], center = false);
    translate([-size/2,-size/2,-size/2]) cube([size,size,size*1/9], center = false);
    }
}

module torus(radius, thickness)
{
    rotate_extrude(convexity = 10)
        translate([radius, 0, 0])
            circle(r = thickness, $fn = 50);
}

module saigon_basket(bucket_size)
{
  union()
  {
      difference()
      {
          bucketshape(bucket_size);
          translate([0,0,0.1])
              bucketshape(bucket_size-1);
          #translate([0,0,-1])
              rotate([90,0,0])
                  cylinder(bucket_size, r=0.3, center = true);
          #translate([0,0,-1])
              rotate([90,90,90])
                  cylinder(bucket_size, r=0.3, center = true);
      }

      torus(bucket_size/2, 0.5);
  }
}

saigon_basket(30);