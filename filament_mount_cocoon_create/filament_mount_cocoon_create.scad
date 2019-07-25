/*
    Filament Mounting Clip For Cocoon Create
    By Brian Khuu 2019
*/
$fn=100;

/*
# Filament Mount Z
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

/*
# Filament Mount Z
[<====y====>]
[ ^ ]
[ | ]
[ x ]
[ | ]
[ V ]
*/
printer_frame_tol=1;
printer_frame_clip_thickness=1.5;
printer_frame_y_lenght = 50;
printer_frame_x_lenght = 50;
metal_sheet_thickness=2+printer_frame_tol;

module sheet_metal(width)
{
    translate([0,0,-1])
    union()
    {
        hull()
        {
            translate([0,0,0])
                cylinder(r=metal_sheet_thickness/2, h=width+2);
            translate([0,printer_frame_y_lenght-metal_sheet_thickness,0])
                cylinder(r=metal_sheet_thickness/2, h=width+2);
        }
        hull()
        {
            translate([0,0,0])
                cylinder(r=metal_sheet_thickness/2, h=width+2);
            translate([printer_frame_x_lenght-metal_sheet_thickness,0,0])
                cylinder(r=metal_sheet_thickness/2, h=width+2);
        }
        cube([(printer_frame_x_lenght-metal_sheet_thickness),(printer_frame_y_lenght-metal_sheet_thickness)*3/4,width+2]);
    }
}

module sheet_metal_clip(width, thickness)
{
    diameter=metal_sheet_thickness+thickness*2;
    translate([thickness*2,thickness*2,0])
    difference()
    {
        union()
        {
            /* Clip */
            hull()
            {
                translate([0,0,0])
                    cylinder(r=diameter/2, h=width);
                translate([0,printer_frame_y_lenght-diameter/2,0])
                    cylinder(r=diameter/2, h=width);
            }
            hull()
            {
                translate([0,0,0])
                    cylinder(r=diameter/2, h=width);
                translate([printer_frame_x_lenght-diameter/2,0,0])
                    cylinder(r=diameter/2, h=width);
            }
            
            /* Tab */
            hull()
            {
                translate([printer_frame_x_lenght-diameter/2,0,0])
                    cylinder(r=diameter/2, h=width);
                translate([printer_frame_x_lenght-diameter/2+10,0,0])
                    cylinder(r=1, h=width);
            }
            
            /* Cable Clip*/
            hull()
            {
                translate([filament_mount_x_offset+filament_mount_thickness+2,-filament_mount_y_offset*3/4,0])
                    cylinder(r=filament_mount_thickness/2, h=width);
                translate([filament_mount_x_offset+filament_mount_thickness+1.5,0,0])
                    cylinder(r=filament_mount_thickness/2, h=width);
            }
            
            /* Mount Offset*/
            hull()
            {
                translate([filament_mount_x_offset,-filament_mount_y_offset,0])
                    cylinder(r=filament_mount_thickness/2, h=width);
                translate([filament_mount_x_offset,0,0])
                    cylinder(r=filament_mount_thickness/2, h=width);
            }
            
            /* Mount */
            translate([filament_mount_x_offset-filament_mount_x_length,-filament_mount_y_offset,0])
            union()
            {
                hull()
                {
                    translate([0,0,0])
                        cylinder(r=filament_mount_thickness/2, h=width);
                    translate([0,-filament_mount_y_length+filament_mount_thickness,0])
                        cylinder(r=filament_mount_thickness/2, h=width);
                }
                hull()
                {
                    translate([0,0,0])
                        cylinder(r=filament_mount_thickness/2, h=width);
                    translate([filament_mount_x_length,0,0])
                        cylinder(r=filament_mount_thickness/2, h=width);
                }
            }
            
            
        }
        sheet_metal(width);
    }
}

sheet_metal_clip(filament_mount_width,printer_frame_clip_thickness);