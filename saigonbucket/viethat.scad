$fn=50;
// Saigon style hat

module viethat(size, thickness, holesize)
{
    difference()
    {
        cylinder(size, r1=size, r2=0);
        translate([0,0,-0.1])
            cylinder(size-thickness, r1=size-thickness, r2=0);
        translate([0,0,size/10]) 
            rotate([90,0,0]) 
                cylinder(100, r=holesize, center=true);
    }
}

viethat(25, 1, 0.5);