/*
    Filament Sensor Mounting Clip For Cocoon Create Touch and Wanhao i3 duplicator plus Rev2.0
    By Brian Khuu 2019
    
    This is for a cheap filament sensor, that you can usually find on ebay.
    This time it will clip right on to the NEMA17 extruder motor of a Cocoon Create Touch
    and Wanhao i3 duplicator plus.
*/
$fn=100;

/*
# Filament Sensor Mount
[<====y====>]
        [ ^ ]
        [ | ]
        [ x ]
        [ | ]
        [ V ]
*/
filament_mount_y_length=6;
filament_mount_x_length=5;
filament_mount_y_offset=20;
filament_mount_x_offset=40;
filament_mount_width=8.5;
filament_mount_thickness=1.5;


// NEMA17 clip
// Rounded by 5mm
NEMA_dia=42.3;
NEMA_clip_round=10; // Adjust based on motor indentation
NEMA_clip_width=8;
NEMA_clip_thickness=3;

NEMA_mount_offset_h=9;
NEMA_mount_offset_length=15;
NEMA_mount_offset_sideway=-5+2.125; // e.g. (Centerpoint=-5, sensor_hole_offset=2.125) --> sideoffset = -5 + 2.125

module rcube(size, radius) 
{
    /* https://blog.prusaprinters.org/parametric-design-in-openscad/ */
    hull() 
    {
        // BL
        if(radius[0] == 0) cube([1, 1, size[2]]);
        else translate([radius[0], radius[0]]) cylinder(r = radius[0], h = size[2]);
        // BR
        if(radius[1] == 0) translate([size[0] - 1, 0]) cube([1, 1, size[2]]);
        else translate([size[0] - radius[1], radius[1]]) cylinder(r = radius[1], h = size[2]);
        // TR
        if(radius[2] == 0) translate([size[0] - 1, size[1] - 1])cube([1, 1, size[2]]);
        else translate([size[0] - radius[2], size[1] - radius[2]]) cylinder(r = radius[2], h = size[2]);
        // TL
        if(radius[3] == 0) translate([0, size[1] - 1]) cube([1, 1, size[2]]);
        else translate([radius[3], size[1] - radius[3]]) cylinder(r = radius[3], h = size[2]);
    }
}


module filament_sensor_mount(xextra, yextra)
{
    /* Mount */
    translate([-filament_mount_x_length-xextra,0,0])
    union()
    {
        translate([0,-yextra,0])
        union()
        {
            hull()
            {
                translate([0,0,0])
                    cylinder(r=filament_mount_thickness/2, h=filament_mount_width);
                translate([0,-filament_mount_y_length+filament_mount_thickness,0])
                    cylinder(r=filament_mount_thickness/2, h=filament_mount_width);
            }
            hull()
            {
                translate([0,0,0])
                    cylinder(r=filament_mount_thickness/2, h=filament_mount_width);
                translate([filament_mount_x_length+xextra,0,0])
                    cylinder(r=filament_mount_thickness/2, h=filament_mount_width);
            }
        }

        hull()
        {
            translate([filament_mount_x_length+2,-yextra,0])
                cylinder(r=filament_mount_thickness/2, h=filament_mount_width);
            translate([filament_mount_x_length+xextra,0,0])
                cylinder(r=filament_mount_thickness/2, h=filament_mount_width);
            translate([filament_mount_x_length+xextra,-yextra,0])
                cylinder(r=filament_mount_thickness/2, h=filament_mount_width);
        }
    }
}

module NEMA_Clip()
{
    difference()
    {
        // NEMA Clip
        translate([-NEMA_clip_thickness,-NEMA_dia/2-NEMA_clip_thickness,0])
            rcube([NEMA_dia+(NEMA_clip_thickness*2),NEMA_dia+(NEMA_clip_thickness*2),NEMA_clip_width],[NEMA_clip_round,NEMA_clip_round,NEMA_clip_round,NEMA_clip_round]);
        
        // NEMA Bulk
        translate([0,-NEMA_dia/2,-5])
            rcube([NEMA_dia,NEMA_dia,NEMA_clip_width+10],[NEMA_clip_round,NEMA_clip_round,NEMA_clip_round,NEMA_clip_round]);

        // Cut
        cutlength=NEMA_dia-5;
        translate([NEMA_dia-(NEMA_clip_thickness*3)/2,-cutlength/2,-5])
            cube([NEMA_clip_thickness*3,cutlength,NEMA_clip_width+10]);
    }
}

// NEMA to Filament Sensor Clip
union()
{
    translate([0,NEMA_mount_offset_sideway,0])
    union()
    {
        translate([-filament_mount_thickness/2,-filament_mount_width/2,filament_mount_thickness/2])
            rotate([-90,0,0])
                filament_sensor_mount(NEMA_mount_offset_h, NEMA_mount_offset_length);

        translate([-NEMA_clip_thickness,-filament_mount_width/2])
            cube([NEMA_clip_thickness,filament_mount_width,NEMA_mount_offset_length]);
    }

    NEMA_Clip();
}
