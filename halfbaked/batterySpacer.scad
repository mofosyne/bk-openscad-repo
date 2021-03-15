/*

Object Name: Battery Spacer (OpenSCAD)
Author: Brian Khuu 2021

Attempt at a battery spacer. Did not quite work out.

*/

module spacerHex()
{
    difference()
    {
        cylinder(d=22-0.5, h=4.5, $fn = 100, center=true);
        cylinder(d=15, h=5, $fn = 6, center=true);
    }
}


module spacerFoil()
{
    spacerH = 4.5;
    spacerR = 22-0.5;
    spacerInner = 14;
    spacerTopHoleDia = 12;
    spacerBottomHoleDia = 12;
    spacerThickness = 0.5;
    
    
    foilThickness = 0.02;
    
    innerH = spacerH-2*spacerThickness;
    foilLayerCountReq = innerH/foilThickness;

    difference()
    {
        cylinder(d=spacerR, h=spacerH, $fn = 100, center=true);
        
        // Internal Foil
        cube([spacerInner,spacerInner,innerH], center=true);
        
        // BottomHole
        translate([0,0,-2])
            cylinder(d=spacerTopHoleDia, h=2, $fn = 100, center=true);
        
        // Top Hole
        translate([0,0,spacerH-2])
            cylinder(d=spacerBottomHoleDia, h=2, $fn = 100, center=true);
    }
    
    echo("pause layer at", spacerH-spacerThickness, "mm");
    echo("innerH ", innerH);
    echo("req ", foilLayerCountReq , " x foil layer");
}

spacerFoil();