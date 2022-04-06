$fn = 100;

cubetolx = 5;
cubetoly = 1.5;
cubecut = 25; // 2.5cm
cubespacing = 75; // 7.5cm
cubegrip = 3; // 2cm

holderw = cubespacing+cubecut*2;
holderh = 5;

bottlew = 70; // 6.6cm
bottleholderh = 5; // 4cm

mountoffset=0;
wall = 3;

//rotate([0,45,0])
difference()
{
    hull()
    {
        translate([0,0,0-1])
        hull()
        {
            cylinder(h=holderh+1, r=bottlew/2+wall);
            translate([0,bottlew/2-mountoffset,(holderh+1)/2])
                cube([holderw, cubecut+wall*2+cubegrip*2, (holderh+1)], center = true);
        }
        cylinder(h=bottleholderh+1, r=bottlew/2+wall);
    }
    
    if(0)
    hull()
    {
        translate([0,0,4])
        cylinder(h=bottleholderh+1+1, r=bottlew/2);
        cylinder(h=0.5, r=bottlew/2-2);
    }
    
    for(deg = [-45 : 10 : +45])
    rotate([0,deg,0])
    union()
    {
        translate([cubespacing/2+cubecut/2,bottlew/2-mountoffset,(holderh+1)/2-1])
            cube([cubecut+cubetolx, cubecut+cubetoly, (holderh+3-1)+10], center = true);
        translate([-cubespacing/2-cubecut/2,bottlew/2-mountoffset,(holderh+1)/2-1])
            cube([cubecut+cubetolx, cubecut+cubetoly, (holderh+3-1)+10], center = true);
    }
    
    //cylinder(h=wall, r=bottlew*0.6/2, center=true);
}


%translate([cubespacing/2+cubecut/2,bottlew/2-mountoffset,(holderh+1)/2-1])
    cube([cubecut, cubecut, (holderh+3-1)+1000], center = true);
%translate([-cubespacing/2-cubecut/2,bottlew/2-mountoffset,(holderh+1)/2-1])
    cube([cubecut, cubecut, (holderh+3-1)+1000], center = true);