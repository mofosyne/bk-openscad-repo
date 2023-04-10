$fn = 40;

module fusionPartyLogo(d=1.2, t=0.5)
{
    for (i=[0:60:360])
    {
        rotate([0,0,i-60])
        translate([d,0,0])
            rotate_extrude(convexity = 10)
            translate([6.5, 0, 0])
            circle(r = t/2);
    }
}

fusionPartyLogo(2, 1);

translate([9.5,0,0])
    rotate_extrude(convexity = 10)
    translate([1, 0, 0])
    circle(r = 1/2);