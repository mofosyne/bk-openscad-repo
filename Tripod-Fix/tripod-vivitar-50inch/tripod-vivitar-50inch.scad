$fn=40;

rotateHeadDia=19.5;
rotateHeadHeight=15;
rotateScrewShaftDia=4.9;

tubeInnerDia=15;
tubeInnerCutoutDia=12.7;
tubeInnerCutoutWidth=4;
tubeInnerTol=1;
tubeInnerDepth=15;

difference()
{
    union()
    {
        // Rotate Head
        rotate([0,180,0])
        difference()
        {
            translate([0,0,0])
                cylinder(r=rotateHeadDia/2,h=rotateHeadHeight);
            translate([0,0,15/2])
                rotate_extrude(convexity=10, $fn=100)
                    translate([18.5/2, 0, 0])
                        circle(r=rotateScrewShaftDia/2, $fn = 100);
        }

        // Inner Pole Grip
        rotate([0,0,0])
        union()
        {
            difference()
            {
                hull()
                {
                    cylinder(r=tubeInnerDia/2,h=tubeInnerDepth*0.5);
                    cylinder(r=tubeInnerDia/2-tubeInnerTol,h=tubeInnerDepth);
                }
                translate([0,0,tubeInnerDepth/2])
                    cube([tubeInnerCutoutWidth,tubeInnerDia,tubeInnerDepth+0.5], center=true);
            }
            cylinder(r1=tubeInnerCutoutDia/2, r2=tubeInnerCutoutDia/2-tubeInnerTol,h=tubeInnerDepth);
        }
    }
    
    rotate([0,180,0])
        translate([0,0,-0.5])
        cylinder(r=tubeInnerCutoutDia/4,h=rotateHeadHeight+1);
    rotate([0,0,0])
        translate([0,0,-0.5])
        cylinder(r=tubeInnerCutoutDia/4,h=tubeInnerDepth+1);
}