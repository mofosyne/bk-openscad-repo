// Holden Astra Gear Selection Button Replacement
// Brian Khuu June 2020
// Description: Was fixing a broken gear selection button from a holden astra car
// Note: Added taper to avoid getting stuck when pressed

/* [Oval Spec] */
// Width : Measured 34mm
oval_w = 34;
// Heigh : Measured 22mm
oval_h = 22;
// Skirt : Tested 8mm
oval_s = 8;
// Button Tolerance (Shrink) : Tested 2.5mm
ButtonTolerance = 2.5;

/* [Mount Post Spec] */
// Width : Measured 7mm
post_w = 7;
// Height : Measured 9mm
post_h = 9;
// Depth : Measured 10mm
post_d = 9;
// Hole Windage (Larger Hole) : 0.1mm
post_windage = 0.1;

/* [Mount Post Locking Post] */
// Post Lock Width : Measured 2mm
postlock_w = 2;
// Post Lock Heigh : Measured 7mm
postlock_h = 7-0.5; 
// Post Lock Fiction : Tested 0.3mm
postlock_friction = 0.3;

/* Includes */
use <MCAD/regular_shapes.scad>

/* Smoothing Adjustment */
$fn=100;

module button()
{
    bulkc_d = post_d + oval_s;
    postc_d = post_d + oval_s;
    
    // Button
    difference()
    {
        union()
        { 
            hull()
            {
                // Smoothing Bump
                oval_prism((bulkc_d*1.15), (oval_w-ButtonTolerance)*0.5/2, (oval_h-ButtonTolerance)*0.5/2);
                oval_prism((bulkc_d*1.1), (oval_w-ButtonTolerance)*0.8/2, (oval_h-ButtonTolerance)*0.8/2);
                
                // Bulk
                oval_prism(bulkc_d, (oval_w-ButtonTolerance)/2, (oval_h-ButtonTolerance)/2);
            }
            
        }

        // Hole
        translate([0,0,postc_d/2 - 0.1])
            cube([post_h,post_w,postc_d] + [post_windage,post_windage,0.1], center=true);
        
        // Hole Taper
        hull()
        {
            translate([0,0,2])
                cube([post_h,post_w,0.2], center=true);
            translate([0,0,-0.1])
                cube([post_h+2,post_w+2,0.2], center=true);
        }
    }
}

module button_with_postlock()
{
    postc_d = post_d + oval_s;

    difference()
    {
        union()
        {
            button();
            
            // The holden astra has a alignment post
            // postlock_friction is there to allow the locking post to grip the post
            hull()
            {
                // Button Locking Post
                translate([(post_h-postlock_h)/2,0,postc_d])
                    cube([postlock_h,postlock_w+postlock_friction,(1)] + [post_windage,post_windage,0], center=true);
                // Button Locking Post
                translate([(post_h-postlock_h)/2,0,0.1])
                    cube([postlock_h,postlock_w,0.1] + [post_windage,post_windage,0], center=true);
                // Button Locking Post (gapfill)
                translate([(post_h)/2+1.1,0,0.1])
                    cube([0.1,postlock_w,0.1] + [post_windage,post_windage,0], center=true);
            }
        }
        
        hull()
        {
            translate([0,0,oval_s])
                oval_prism(0.1, (oval_w-8)/2, (oval_h-8)/2);
    
            translate([0,0,-0.1])
                oval_prism(0.1, (oval_w-5)/2, (oval_h-5)/2);
        }
    }
}

// Rotated to good print orientation
rotate([180,0,0])
button_with_postlock();