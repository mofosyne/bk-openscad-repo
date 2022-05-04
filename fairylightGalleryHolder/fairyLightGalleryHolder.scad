$fn = 40;

/* [Mounting Strip Base]  */
/* Command Strip dimentions is typically 50mmx15mm */
sx = 50 ; // length of mounting strip base
sy = 15 ; // widith of mounting strip base
sh = 2  ; // height of mounting strip base

/* [Fairy Light Battery] */
ft = 2; // Thickness
fh = 33;
fw = 18;
fd = 74;

// 120mm

thickness = 1;

translate([0,0,sy/2])
union()
{
    // Fairy light mount
    difference()
    {
        union()
        {
            translate([0,0,sy/2])
                mirror([0,0,1])
                linear_extrude(height = sy/2, scale = 1.1)
                import("fairlyLightGalleryHolderCurve.svg");
            translate([0,0,-sy/2])
                linear_extrude(height = sy/2, scale = 1.1)
                import("fairlyLightGalleryHolderCurve.svg");
        }
        
        translate([0,135,0])
            cylinder(r=10, h=0.8, center=true);
        translate([90,60,0])
            cylinder(r=10, h=0.8, center=true);
    }

    // Cable Tie
    translate([(sx)/2+30,10/2,0])
    difference()
    {
        cube([sx,10,sy], center = true);
        hull()
        {
            translate([sx/2,0,-50])
                cylinder(r=4, h=100);
            translate([sx/3,0,-50])
                cylinder(r=2, h=100);
        }
        hull()
        {
            translate([-sx/3,0,-50])
                cylinder(r=2, h=100);
            translate([-sx/2,0,-50])
                cylinder(r=4, h=100);
        }
        if (0)
        {
            // Extra flang cut
            hull()
            {
                translate([sx/2,0,0])
                    rotate([90,0,0])
                    cube([1,6,100], center=true);
                translate([sx/3,0,0])
                    rotate([90,0,0])
                    cube([1,1,100], center=true);
            }
            hull()
            {
                translate([-sx/2,0,0])
                    rotate([90,0,0])
                    cube([1,6,100], center=true);
                translate([-sx/3,0,0])
                    rotate([90,0,0])
                    cube([1,1,100], center=true);
            }
        }
        if (0)
        {
            hull()
            {
                translate([0,-1,sy/2])
                    cube([sx,6,0.01], center = true);
                translate([0,-1,sy/3])
                    cube([sx,1,0.01], center = true);
            }
            hull()
            {
                translate([0,-1,-sy/2])
                    cube([sx,6,0.01], center = true);
                translate([0,-1,-sy/3])
                    cube([sx,1,0.01], center = true);
            }
        }
        hull()
        {
            translate([0,10/2,0])
                rotate([0,0,90])
                cube([0.1,25,100], center=true);
            translate([0,-10/2,0])
                rotate([0,0,90])
                cube([0.1,10,100], center=true);
        }
    }
    
    
    // Strip
    translate([sx/2+30,0,0])
        cube([sx,sh,sy], center = true);
}
    