/*

Object Name: Bird Bath (OpenSCAD)
Author: Brian Khuu 2021

Based on https://www.reddit.com/r/functionalprint/comments/jgg3fk/sanitiser_mount_on_a_fence_openscad/ but remixed with "Auto refill Water fountain for turtle" by vinneB https://www.thingiverse.com/thing:632553/files

*/

$fn = 100;

cubetolx = 5;
cubetoly = 1.5;
cubecut = 25; // 2.5cm
cubespacing = 75; // 7.5cm
cubegrip = 3; // 2cm

holderw = cubespacing+cubecut*2;
holderh = 10;

bottlew = 70; // 6.6cm 
bottleholderh = 5;//40; // 4cm

mountoffset=0;
wall = 3;


//////////////////////////////////////////////
// REF: Auto refill Water fountain for turtle 
//      by vinnieB January 13, 2015
// https://www.thingiverse.com/thing:632553/files
bottlescrewTol = 2.5;

rad  = 30-bottlescrewTol;
rad2 = 28-bottlescrewTol;
heit = 8;

thick = 2.4;

module bottleRing()
{
    difference()
    {
        cylinder(r = rad/2+thick,h=heit);
        translate([0,0,heit/2])
            cylinder(r=rad/2,h=heit+.1, center=true);
    }

    for(i=[0:2])
    {
        translate([cos(120*i)*rad2/2,sin(120*i)*rad2/2,heit-4.2])
            rotate(i*120+5,[0,0,1])
                rotate(45,[0,1,0])
                    cube([1.5,3,1.5]);
    }
}

module waterBak1()
{
	hull()
	{
        translate([0,0,0])
            cylinder(r=rad/2+thick,h=15);
        translate([60,0,0])
            cylinder(r=60,h=8);
	}
}

/////////////////////////////////////////////////////////////


//if (0)
difference()
{
    union()
    {
        hull()
        {
            translate([0,0,0-1])
            hull()
            {
                translate([0,bottlew/2-mountoffset,(holderh+1)/2])
                    cube([holderw, cubecut+wall*2+cubegrip*2, (holderh+1)], center = true);
            }
            
            rotate([0,0,-90])
                translate([0,0,-1])
                    scale([1,1,1.0])
                        waterBak1(); ///< BirdBathStuff Dish
        }
        
        /// BirdBathStuff
        rotate([0,0,-90])
                translate([0,0,0])
                    cylinder(r=rad/2+thick,h=18); ///< Bottle Cap
    }

    /// BirdBathStuff
    rotate([0,0,-90])
    {
        translate([3,0,.6])
            scale([.94,.94,1.0])
                waterBak1(); ///< Dish
        translate([0,0,2])
            cylinder(r=rad/2,h=18); ///< Bottle Cap Center Cut
    }
    /// End of BirdBathStuff

    for(deg = [-45 : 10 : +45])
    rotate([0,deg,0])
    union()
    {
        translate([cubespacing/2+cubecut/2,bottlew/2-mountoffset,(holderh+1)/2-1])
            cube([cubecut+cubetolx, cubecut+cubetoly, (holderh+3-1)+10], center = true);
        translate([-cubespacing/2-cubecut/2,bottlew/2-mountoffset,(holderh+1)/2-1])
            cube([cubecut+cubetolx, cubecut+cubetoly, (holderh+3-1)+10], center = true);
    }
}

rotate([0,0,-90])
{
    difference()
    {
        translate([0,0,0])
            cylinder(r=rad/2+thick,h=18); ///< Bottle Cap
        translate([0,0,2])
            cylinder(r=rad/2,h=18); ///< Bottle Cap Center Cut
        hull()
        {
            translate([10-20,45-50,2])
                cube([5,10,4]); ///< Bottle Cap Water Output
            translate([10,45-50,0.6])
                cube([10,10,10]); ///< Bottle Cap Water Output
        }
    }
    translate([0,0,18])
        rotate(180,[1,0,0])
            bottleRing();
}

/// Model of wall
if (1)
{
%translate([cubespacing/2+cubecut/2,bottlew/2-mountoffset,(holderh+1)/2-1])
    cube([cubecut, cubecut, (holderh+3-1)+1000], center = true);
%translate([-cubespacing/2-cubecut/2,bottlew/2-mountoffset,(holderh+1)/2-1])
    cube([cubecut, cubecut, (holderh+3-1)+1000], center = true);
} 



