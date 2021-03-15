$fn=100;
/*

Object Name: Fence Mount for solar lights (OpenSCAD)
Author: Brian Khuu 2021

*/

solarMountDiameter = 10+0.5;
solarClipLength = 8;
solarClipThickness = 7;
solarMountThickness = 50;

module fenceModel()
{
    hull()
    {
        xx = 62;
        yy = 100;
        zz = 25;

        rotate([0,0,0])
            cube([xx,yy,zz], center=true);
        rotate([0,45,0])
            cube([xx,yy,zz], center=true);
        rotate([0,-45,0])
            cube([xx,yy,zz], center=true);
        rotate([0,90,0])
            cube([xx,yy,zz], center=true);
    }
}

module lightMount()
{
    rotate([-90,0,0])
    difference()
    {
        xx = 62+solarClipThickness;
        yy = solarClipLength;
        zz = 25;

        union()
        {
            if (0)
            {
                // Solar Device Mount
                translate([0,0,xx/2])
                intersection()
                {
                    cylinder(r=solarMountDiameter/2, h=10);
                    translate([0,solarMountDiameter/4,0])
                        cube([solarMountDiameter,solarMountDiameter/2,zz], center=true); 
                }
                translate([0,0,xx/2])
                intersection()
                {
                    cylinder(r=solarMountDiameter/2, h=10);
                    translate([0,0,0])
                    cube([solarMountDiameter/4,solarMountDiameter,zz], center=true); 
                }
            }
            else
            {
                // Light mount
                translate([0,0,xx/2])
                intersection()
                {
                    difference()
                    {
                        cylinder(r=solarMountDiameter*0.5, h=20);
                        translate([0,0,0])
                        cube([1,solarMountDiameter,zz], center=true); 
                    }
                    cube([solarMountDiameter,solarClipLength,zz], center=true); 
                }
            }
            hull()
            {
                rotate([0,0,0])
                    cube([xx,yy,zz], center=true);
                rotate([0,45,0])
                    cube([xx,yy,zz], center=true);
                rotate([0,-45,0])
                    cube([xx,yy,zz], center=true);
                rotate([0,90,0])
                    cube([xx,yy,zz], center=true);
            }
        }
        
        fenceModel();
        
        translate([0,0,-zz])
            cube([xx*0.7,100,zz], center=true);
        
        // For easier seperation
        translate([0,0,-zz])
            rotate([45,0,0])
            translate([0,0-5,0])
            cube([100,10,zz], center=true);
        translate([0,0,-zz])
            rotate([-45,0,0])
            translate([0,5,0])
            cube([100,10,zz], center=true);
    }
}


module solarMount()
{
    rotate([-90,0,0])
    difference()
    {
        xx = 62+solarClipThickness;
        yy = solarMountThickness;
        zz = 25;

        union()
        {
            // Light mount
            translate([0,0,xx/2])
            intersection()
            {
                ll = 50;
                difference()
                {
                    cylinder(r=solarMountDiameter*0.5, h=ll);
                    translate([0,0,zz/2])
                        cube([1,solarMountDiameter,zz+1], center=true); 
                }
                cube([solarMountDiameter,solarClipLength,ll], center=true); 
            }
            hull()
            {
                rotate([0,0,0])
                    cube([xx,yy,zz], center=true);
                rotate([0,45,0])
                    cube([xx,yy,zz], center=true);
                rotate([0,-45,0])
                    cube([xx,yy,zz], center=true);
                rotate([0,90,0])
                    cube([xx,yy,zz], center=true);
            }
        }
        
        fenceModel();
        
        translate([0,0,-zz])
            cube([xx*0.7,100,zz], center=true);

        union()
        {
            rotate([0,0,0])
                cube([xx+10,yy-10,zz-5], center=true);
            rotate([0,45,0])
                translate([-10,0,0])
                cube([xx,yy-10,zz-5], center=true);
            rotate([0,-45,0])
                translate([10,0,0])
                cube([xx,yy-10,zz-5], center=true);
        }
    }
}


// Light Mount
if (1)
{ 
    for(i = [0:1:6])
    {
        layerGapSpacing = 0.45;
        translate([0,0,i*(solarClipLength+layerGapSpacing)])
            lightMount();
    }
}

// Solar Mount
if (0)
    solarMount();