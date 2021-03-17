$fn=100;
/*

Object Name: Adapter For Laptop Chest Stand (OpenSCAD)
Author: Brian Khuu 2021

*/

adapterL=220;
adapterH=20-5;
adapterAngle=20; 

adapterHingeOffset=5;

currGapW=15-0.5;
newGapW=15;
newGapH=60;
newGapThickness=8;

translate([0,0,-adapterH/2])
    cube([currGapW,adapterL,adapterH], center=true);

difference()
{
    union()
    {
        // base
        hull()
        {       
            translate([0,0,0.005])
                    cube([currGapW,adapterL,0.01], center=true);
            translate([0,0,adapterHingeOffset])
                rotate([0,adapterAngle,0])
                translate([0,0,0.005+5])
                cube([newGapW+newGapThickness,adapterL,0.01+5], center=true);
        }

        // top
        intersection()
        {
            hull()
            {
                translate([0,0,0.005])
                        cube([currGapW,adapterL,0.01], center=true);
                translate([0,0,adapterHingeOffset])
                    rotate([0,adapterAngle,0])
                    translate([0,0,newGapH/2+5])
                    cube([newGapW+newGapThickness,adapterL,newGapH+5], center=true);
            }
            hull()
            {
                roundness=20;
                translate([0,0,adapterHingeOffset])
                    rotate([0,adapterAngle,0])
                    translate([0,adapterL/2-newGapH+roundness,7]) 
                    rotate([0, 90,0])
                    cylinder(r=newGapH,h=1000, center=true);
                translate([0,0,adapterHingeOffset])
                    rotate([0,adapterAngle,0])
                    translate([0,-adapterL/2+newGapH-roundness,7]) 
                    rotate([0, 90,0])
                    cylinder(r=newGapH,h=1000, center=true);
            }
        }
    }
    
    // Gap Cut
    translate([0,0,adapterHingeOffset])
        rotate([0,adapterAngle,0])
        translate([0,0,newGapH/2+5+4])
        cube([newGapW,adapterL+1,newGapH+4], center=true);
    
    // Middle slit for trackpad
    hull()
    {
        // Big slit
        translate([0,0,adapterHingeOffset])
            rotate([0,adapterAngle,0])
            translate([0,0,newGapH+7]) 
            rotate([0,90,0])
            cylinder(r=newGapH,h=1000, center=true);
        
        // Little
        translate([0,0,adapterHingeOffset])
            rotate([0,adapterAngle,0])
            translate([0,adapterL/2-newGapH+15,5+5+newGapH]) 
            rotate([0,90,0])
            cylinder(r=3,h=1000, center=true);
        translate([0,0,adapterHingeOffset])
            rotate([0,adapterAngle,0])
            translate([0,-(adapterL/2-newGapH+15),5+5+newGapH]) 
            rotate([0,90,0])
            cylinder(r=3,h=1000, center=true);
    }
    

}