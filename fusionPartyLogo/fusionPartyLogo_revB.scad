$fn = 40;

module fusionPartyLogo(ringRadius=9.0, lineThickness=0.8, loopThickness=0.7, loopHole=1.0)
{
    ringOffset=ringRadius/3;
    
    translate([ringRadius+ringOffset+lineThickness+loopThickness+loopHole/2,0,0])
    difference()
    {
        cylinder(r=1.0+lineThickness, h=1.0, center=true);
        cylinder(r=1.0, h=1.1, center=true);
    }
    
    stepAngle=72;
    for (i=[0:1:4])
    {
        rotate([0,0,i*stepAngle-stepAngle*2])
        translate([ringOffset,0,0])
            difference()
            {
                cylinder(r=ringRadius+lineThickness, h=1.0, center=true);
                cylinder(r=ringRadius, h=1.1, center=true);
            }
    }
}

fusionPartyLogo();
