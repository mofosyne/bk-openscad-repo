$fn=40;

tubeInnerDia=14.8;
tubeInnerCutoutDia=12.7;
tubeInnerTol=1;

translate([0,0,0])
    cylinder(r1=18.5/2, r2=18.5/2-1,h=5);
translate([0,0,5])
    cylinder(r=18.5/2-1,h=5);
translate([0,0,5+5])
    cylinder(r2=18.5/2, r1=18.5/2-1,h=5);

difference()
{
    translate([0,0,-10])
        cylinder(r2=tubeInnerDia/2,r1=tubeInnerDia/2-tubeInnerTol,h=10);
    cube([4,15,11*2], center=true);
}

translate([0,0,-10])
    cylinder(r2=tubeInnerCutoutDia/2, r1=tubeInnerCutoutDia/2-tubeInnerTol,h=10);