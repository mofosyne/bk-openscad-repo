$fn = 100;

module fusionPartyLogo_with_keyring(ringRadius=9.0, lineThickness=0.8, loopThickness=0.7, loopHole=1.0)
{
    ringOffset=ringRadius/3;
    
    translate([ringRadius+ringOffset+lineThickness+loopThickness+loopHole/2,0,0])
    difference()
    {
        circle(r=1.0+lineThickness);
        circle(r=1.0);
    }
    
    fusionPartyLogo_2D();
}
module fusionPartyLogo_2D(ringRadius=9.0, lineThickness=0.8, loopThickness=0.7, loopHole=1.0)
{
    ringOffset=ringRadius/3;
    
    stepAngle=72;
    for (i=[0:1:4])
    {
        rotate([0,0,i*stepAngle-stepAngle*2])
        translate([ringOffset,0,0])
            difference()
            {
                circle(r=ringRadius+lineThickness);
                circle(r=ringRadius);
            }
    }
}

if (1)
{
    // 3D printed
    linear_extrude(1)
        fusionPartyLogo_with_keyring();
}
else
{
    // 2D For Cutters
    fusionPartyLogo_with_keyring();
}
