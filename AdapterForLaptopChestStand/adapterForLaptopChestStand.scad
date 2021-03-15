$fn=100;
/*

Object Name: Adapter For Laptop Chest Stand (OpenSCAD)
Author: Brian Khuu 2021

*/

adapterL=220;
adapterH=20-5;
adapterAngle=10; 

currGapW=15-0.5;
newGapW=15;
newGapH=20;
newGapThickness=10;

translate([0,0,-adapterH/2])
    cube([currGapW,adapterL,adapterH], center=true);

difference()
{
    hull()
    {       
        translate([0,0,+5])
            cube([currGapW,adapterL,10], center=true);
        translate([0,0,+5])
            rotate([0,adapterAngle,0])
            translate([0,0,+10+5])
            cube([newGapW+newGapThickness,adapterL,newGapH+5], center=true);
    }

    translate([0,0,+5])
        rotate([0,adapterAngle,0])
        translate([0,0,+10+5+4])
        cube([newGapW,adapterL+1,newGapH+4], center=true);
}