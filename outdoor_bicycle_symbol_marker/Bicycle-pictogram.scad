// Bicycle Pictogram
// Intent: To mount on fences and posts, so you can indicate if a location is friendly for temporary parking of bicycle.
//         E.g. In front of a cafe with cameras etc...
// Author: Brian Khuu 2023

// Mount Spec
fence_mount_depth = 48;
fence_mount_width_top = 48;
fence_mount_width_bottom = 20;
fence_mount_width_thickness = 2.0;

// Bicycle Symbol Thickness
bicycle_symbol_thickness = 1.0;
bicycle_symbol_width = 200;

// Calc
rescaling = bicycle_symbol_width/100;

/////////////////////////////////////////////////////////////////////////
module mount_clip()
{
    mount_width = 10;
    // Mount
    translate([-mount_width/2,0,0])
    cube([mount_width,fence_mount_width_thickness,fence_mount_width_thickness+fence_mount_width_top]);
    translate([-mount_width/2,-fence_mount_depth,0])
    cube([mount_width,fence_mount_width_thickness+fence_mount_depth,fence_mount_width_thickness]);
    translate([-mount_width/2,-fence_mount_width_thickness+-fence_mount_depth,0])
    cube([mount_width,fence_mount_width_thickness,fence_mount_width_thickness+fence_mount_width_bottom]);

    // Clip
    hull()
    {
        translate([-mount_width/2,0,fence_mount_width_thickness+fence_mount_width_top])
            cube([mount_width,fence_mount_width_thickness,11]);
        translate([-mount_width/2,-3,fence_mount_width_thickness+fence_mount_width_top+11-5])
            cube([mount_width,fence_mount_width_thickness,1]);
    }
}

/////////////////////////////////////////////////////////////////////////
// Bicycle-pictogram.svg 100mm length
// Source of image: Retraced and slightly adjusted version of a public domain 
//                  Bicycle symbol found at https://publicdomainvectors.org/en/free-clipart/Bicycle-pictogram-vector-illustration/23113.html
linear_extrude(height=bicycle_symbol_thickness)
scale(rescaling)
import("Bicycle-pictogram.svg");

// Bicycle Clip
translate([18*rescaling,0,0])
    mount_clip();
translate([18*rescaling+65*rescaling,0,0])
    mount_clip();

/////////////////////////////////////////////////////////////////////////
// 25x25mm QR code
translate([45*rescaling,30*rescaling,0])
linear_extrude(height=bicycle_symbol_thickness)
minkowski() 
{
    square([25,25]);
    circle(r=2, $fn=30);
}