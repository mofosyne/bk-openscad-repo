// Bicycle Pictogram
// Intent: To mount on fences and posts, so you can indicate if a location is friendly for temporary parking of bicycle.
//         E.g. In front of a cafe with cameras etc...
// Author: Brian Khuu 2023

// Mount Spec
fence_mount_depth = 10;
fence_mount_width = 48;
fence_mount_length = 200;

// Bicycle Symbol Thickness
bicycle_symbol_thickness = 1.5;

// Calc
rescaling = fence_mount_length/100;

// Bicycle-pictogram.svg 100mm length
linear_extrude(height=bicycle_symbol_thickness)
scale(rescaling)
import("Bicycle-pictogram.svg");

// Mount (You would place a magnetic strip or command strip etc here..,)
translate([15*rescaling,0,0])
cube([70*rescaling,bicycle_symbol_thickness,fence_mount_width]);
translate([15*rescaling,-fence_mount_depth,0])
cube([70*rescaling,fence_mount_depth,1]);