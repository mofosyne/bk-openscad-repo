$fn=40;

difference()
{
    // Upper Hing
    upperthick          = 20;
    upperwidth          = 43;
    upperScrewDia       = 6.5;
    upperScrewCapWidth  = 9 + 0.5;
    upperScrewCapThick  = 4  + 0.5;
    uppercutgap         = 4.1  + 0.5; //4.1
    uppercutpitch       = 8  + 0.0;

    // Lower Hing
    lowerHoleThickness = 5;
    lowerHoleCut       = 22.5 + 1; // 22.5
    lowerScrewDia      = 5    + 1; // 5
    lowerScrewNutCut   = 8    + 1; // 8
    lowerScrewNutThick = 4    + 1; // 4
    
    hull()
    {
        // Upper Hinge
        rotate([00,90,00])
            cylinder(r=upperthick/2, h=upperwidth, center=true);
        
        // Lower Hinge
        translate([0,-35,0])
            cylinder(r=(2*lowerHoleThickness+lowerHoleCut)/2, h=upperthick, center=true);
    }
    
    // Upper hinge screw 
    rotate([00,90,00])
        cylinder(r=upperScrewDia/2, h=upperwidth+1, center=true);
    translate([upperwidth/2-4/2,0,0])
        cube([upperScrewCapThick,upperScrewCapWidth,upperScrewCapWidth], center=true);

    // Upper hinge slots
    for (i=[-2:1:1])
        translate([uppercutpitch/2+i*uppercutpitch,0,0])
            cube([uppercutgap,upperthick+2,upperthick+2], center=true);
    
    // Lower Hinge
    translate([0,-35,0])
    difference()
    {
        cylinder(r=(lowerHoleCut)/2, h=upperthick+1, center=true);
        if (0)
        difference()
        {
            for (i=[0:2:34])
                rotate([0,0,i*10])
                translate([(lowerHoleCut)/2+0.5,0,0])
                rotate([90,0,0])
                cylinder(r=4.5/2, h=5, center=true);
            cylinder(r=(lowerHoleCut-2)/2, h=upperthick+1, center=true);
        }
        %cylinder(r=(lowerHoleCut-4)/2, h=1, center=true);
    }

    // Lower hinge screw 
    translate([0,-22,0])
        rotate([00,0,-12])
        union()
        {
            #rotate([0,90,0])
                cylinder(r=lowerScrewDia/2, h=upperwidth+10, center=true);
            translate([-12,0,0])
            hull()
            {
                translate([0,0,-1])
                    cube([lowerScrewNutThick,lowerScrewNutCut,lowerScrewNutCut], center=true);
                translate([0,0,10])
                    cube([lowerScrewNutThick,lowerScrewNutCut,lowerScrewNutCut], center=true);
            }
        }
        
    // Hing Cut
    cutRad = 1.0;
    vertCut = 15; // 10
    hozCut = -18; // -20
    hull()
    {
        translate([vertCut,hozCut,0])
            rotate([0,0,90])
            cylinder(r=cutRad, h=upperthick+1, center=true);
        translate([0,-30,0])
            rotate([0,0,90])
            cylinder(r=cutRad, h=upperthick+1, center=true);
    }
    hull()
    {
        translate([vertCut,hozCut,0])
            rotate([0,0,90])
            cylinder(r=cutRad, h=upperthick+1, center=true);
        translate([20,hozCut,0])
            rotate([0,0,90])
            cylinder(r=cutRad, h=upperthick+1, center=true);
    }
    
}